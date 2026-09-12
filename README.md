# PocketBase

Due to the fact that [PocketBase](https://arc.net/l/quote/sjkguvqg) does not provide an own Docker image, I created this
repository to provide myself one. If you want, you can also use it. I try to keep it up to date, although I can not
promise something. However, I use this image for my own projects, so it probably will be more or less up-to-date.

[See all versions](https://github.com/m-mattia-m/pocketbase/pkgs/container/pocketbase/versions)

[Example docker compose](https://github.com/m-mattia-m/PocketBase/blob/main/docker-compose.yaml)

## Getting Started

### Environment variables

- `PB_SUPERUSER_EMAIL` to set the email of the initial admin user
- `PB_SUPERUSER_PASSWORD` to set the password of the initial admin user
- `PB_DATA_DIR` (optional) to set the data directory (default is `/pb_data`)
### Start the container

```bash
docker run -d -p 8080:8080 -e PB_SUPERUSER_EMAIL='admin@example.com' --env PB_SUPERUSER_PASSWORD='my-secure-password-123' ghcr.io/m-mattia-m/pocketbase:1.1.0
```

## Versioning

The image version follows the PocketBase version it contains, one major ahead.
PocketBase `v0.40.2` becomes `1.40.2`.

## Updates

Renovate runs every Saturday and opens a PR when there is a newer PocketBase release.
Merging that PR triggers the release workflow, which tags the repo and pushes the new
image to GHCR.

For this to work without me:

- A `RENOVATE_TOKEN` secret with a PAT (`repo` and `workflow` scope) from an account with
  write access. Merges made with the default `GITHUB_TOKEN` don't trigger other workflows,
  so the release would never run.
- *Allow auto-merge* enabled in the repository settings, plus a rule on `main` requiring the
  `build` check so there is something to wait for.

# Development

To build the image locally, you can use the following command:

```bash
docker build . --file ./Dockerfile --tag pocketbase --label 1.0.0
```