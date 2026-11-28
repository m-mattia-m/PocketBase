FROM alpine:latest

ARG PB_VERSION=0.42.3

RUN apk add --no-cache unzip ca-certificates bash

# download and unzip PocketBase
# PocketBase left GitHub in Oct 2026; the GitHub org is archived and frozen at
# v0.40.6, and releases from v0.41.0 on are published only on the new host.
# Old releases were not migrated, so this URL only resolves for >= 0.41.1.
ADD https://ganigeorgiev.com/meta/pocketbase/pocketbase/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
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