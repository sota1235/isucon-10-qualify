FROM mysql:5.7

ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes MYSQL_DATABASE=isucon MYSQL_USER=isucon MYSQL_PASSWORD=isucon

RUN apt update -y && apt install -y git ssh && \
    mkdir /root/.ssh && chmod 700 /root/.ssh && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

ADD sql/* /docker-entrypoint-initdb.d/
ADD mysql/* /etc/mysql/

EXPOSE 3306

CMD ["--character-set-server=utf8mb4"]
