FROM golang:1.10

RUN apt update -y && apt install -y git ssh && \
    GOPATH=/home/isucon/isucon/webapp/go

EXPOSE 8000

ENTRYPOINT ["/bin/bash"]