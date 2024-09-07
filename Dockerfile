FROM alpine:latest
RUN apk add --no-cache curl
COPY run*.sh /bin/
RUN chmod +x /bin/run.sh
ENTRYPOINT ["/bin/sh"]
CMD ["/bin/run.sh"]
