FROM beshleman/debian:latest

COPY ./runvm /usr/local/bin/runvm

ENTRYPOINT ["/usr/local/bin/runvm"]
