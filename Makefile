ISUCON_ORIGIN=https://portal.isucon.net

.PHONY: build deploy benchmark show-log

build: ## build app
	make -C ./isuumo/webapp/go
	#

deploy: build
	## WebApp Deployment
	rsync -av ./isuumo/webapp/go/isuumo isucon10-qualify.app3:/home/isucon/isuumo/webapp/go
	## MySQL
	rsync -av ./etc isucon10-qualify.app3:/home/isucon/ && ssh isucon10-qualify.app3 "sudo cp -v /home/isucon/etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/"

	ssh isucon10-qualify.app3 "sudo systemctl restart isuumo.go.service mysql.service nginx.service"

	# rsync -av ./isuumo/webapp/go/isuumo isucon10-qualify.app2:/home/isucon/isuumo/webapp/ 
	# ssh isucon10-qualify.app2 "sudo systemctl restart isuumo.go.service mysql.service nginx.service"
	#
	# rsync -av ./isuumo/webapp/go/isuumo isucon10-qualify.app3:/home/isucon/isuumo/webapp/ 
	# ssh isucon10-qualify.app3 "sudo systemctl restart isuumo.go.service mysql.service nginx.service"
	# tools/newrelic/deploy.sh

benchmark: ## enqueue
	# ./tools/portal/enqueue
	# ./tools/slack/post

show-log: ## show log
	ssh isucon10-qualify.app3 "sudo tail -f /var/log/syslog"
	# ssh isucon10-qualify.app2 "sudo tail -f /var/log/syslog"
	# ssh isucon10-qualify.app3 "sudo tail -f /var/log/syslog"

.PHONY: help
help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
