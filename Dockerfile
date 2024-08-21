FROM alpine:latest
RUN apk add --no-cache curl
COPY run.sh /bin/run.sh
RUN chmod +x /bin/run.sh
ENTRYPOINT ["/bin/run.sh"]
