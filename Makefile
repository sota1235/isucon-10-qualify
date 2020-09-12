ISUCON_ORIGIN=https://portal.isucon.net

.PHONY: build deploy benchmark show-log

build: ## build app
	make -C webapp/
	#

deploy: build
	# rsync . -av isucon@isucon9-qualify.app1:/home/isucon/isucari/webapp/
	# ssh isucon9-qualify.app1 "sudo systemctl restart isucari.golang.service mysql.service nginx.service"
	# ssh isucon9-qualify.app1 "sudo systemctl status isucari.golang.service mysql.service nginx.service"
	rsync -av ./webapp/isuumo isucon10-qualify.app1:/home/isucon/isuumo/webapp/ 
	# rsync -av ./webapp/isuumo isucon10-qualify.app2:/home/isucon/isuumo/webapp/ 
	# rsync -av ./webapp/isuumo isucon10-qualify.app3:/home/isucon/isuumo/webapp/ 
	ssh isucon10-qualify.app1 "sudo systemctl restart isuumo.go.service"
	tools/newrelic/deploy.sh

benchmark: ## enqueue
	# ./tools/portal/enqueue
	# ./tools/slack/post

show-log: ## show log
	# ssh isucon9-qualify.app1 "sudo tail -f /var/log/syslog"
	# ssh isucon9-qualify.app2 "sudo tail -f /var/log/syslog"
	ssh isucon9-qualify.app3 "sudo tail -f /var/log/syslog"

.PHONY: help
help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
