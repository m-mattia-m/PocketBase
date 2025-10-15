FROM alpine:latest

ARG PB_VERSION=0.23.11

RUN apk add --no-cache unzip ca-certificates bash

# download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/ && chmod +x /pb/pocketbase


# Copy optional migrations or hooks
# COPY ./pb_migrations /pb/pb_migrations
# COPY ./pb_hooks /pb/pb_hooks

# --- entrypoint script ---
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["serve", "--http=0.0.0.0:8080"]