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

The image version mirrors the PocketBase version it ships, one major ahead:

| PocketBase | Image    |
|------------|----------|
| `v0.23.11` | `1.23.11`|
| `v0.40.2`  | `1.40.2` |

PocketBase is still pre-`1.0`, so `0.MINOR.PATCH` maps onto `1.MINOR.PATCH`. If PocketBase
ever reaches `1.x`, this image stays one major ahead (`2.MINOR.PATCH`).

## Automated updates

[Renovate](https://docs.renovatebot.com/) watches the PocketBase releases and keeps
`ARG PB_VERSION` in the [Dockerfile](./Dockerfile) up to date. It runs every **Saturday at
03:00 (Europe/Zurich)** via [`.github/workflows/renovate.yaml`](./.github/workflows/renovate.yaml)
and automerges once the image builds successfully.

Merging a new `PB_VERSION` into `main` triggers
[`.github/workflows/release.yaml`](./.github/workflows/release.yaml), which derives the image
version from `PB_VERSION`, creates the matching GitHub release and kicks off the build and
push to GHCR.

### Repository setup

- Add a repository secret `RENOVATE_TOKEN` containing a classic PAT with the `repo` and
  `workflow` scopes. It is needed because pushes made with the default `GITHUB_TOKEN` do not
  trigger the release workflow. Without it, Renovate falls back to `GITHUB_TOKEN` and updates
  have to be released manually.
- Enable *Settings → General → Allow auto-merge* so Renovate can use GitHub's native
  auto-merge. If a branch protection rule on `main` requires the `build` check, the PR is
  merged as soon as the image builds; otherwise Renovate merges it on its next run.

You can trigger a check at any time from *Actions → Renovate → Run workflow*.

# Development

To build the image locally, you can use the following command:

```bash
docker build . --file ./Dockerfile --tag pocketbase --label 1.0.0
```