
.PHONY: build deploy benchmark show-log

build:
	# make -C webapp/go

deploy:
	# rsync . -av isucon@isucon9-qualify.app1:/home/isucon/isucari/webapp/ 
	# ssh isucon9-qualify.app1 "sudo systemctl restart isucari.golang.service mysql.service nginx.service"
	# ssh isucon9-qualify.app1 "sudo systemctl status isucari.golang.service mysql.service nginx.service"
	tools/newrelic/deploy.sh

benchmark:
	# ./tools/portal/enqueue
	# ./tools/slack/post

show-log:
	# ssh isucon9-qualify.app1 "sudo tail -f /var/log/syslog"
	# ssh isucon9-qualify.app2 "sudo tail -f /var/log/syslog"
	ssh isucon9-qualify.app3 "sudo tail -f /var/log/syslog"

