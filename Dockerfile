# Only use semver version tags. Don't specify distro!
FROM node:16.2.0-stretch

RUN curl --silent -o /usr/local/bin/node-prune https://s3.amazonaws.com/ssi-us-east-1-pkg/node-prune/node-prune-0.1 && \
    chmod +x /usr/local/bin/node-prune && \
    rm -rf /tmp/* && \
    groupadd ssi -r && \
    useradd -r -g ssi ssi

CMD ["echo", "Hello World from node"]
