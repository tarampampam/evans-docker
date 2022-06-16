<p align="center">
  <img src="https://socialify.git.ci/tarampampam/evans-docker/image?forks=1&issues=1&owner=1&stargazers=1&theme=Dark" alt="" width="100%" />
</p>

<p align="center">
  <img src="https://img.shields.io/github/workflow/status/tarampampam/evans-docker/tests?maxAge=30&label=tests&logo=github&style=flat-square" alt="" />
  <img src="https://img.shields.io/github/workflow/status/tarampampam/evans-docker/release?maxAge=30&label=release&logo=github&style=flat-square" alt="" />
  <img src="https://img.shields.io/github/license/tarampampam/evans-docker.svg?maxAge=30&style=flat-square" alt="" />
</p>

## What includes this image?

Docker image with [evans][evans]. Documentation can be found [here][evans].


## Docker image

| Registry                          | Image                       |
|-----------------------------------|-----------------------------|
| [GitHub Container Registry][ghcr] | `ghcr.io/tarampampam/evans` |

All supported image tags [can be found here](https://github.com/tarampampam/evans-docker/pkgs/container/evans/versions).

Following platforms for this image are available:

```bash
$ docker run --rm mplatform/mquery ghcr.io/tarampampam/evans:0.10.5
Image: ghcr.io/tarampampam/evans:0.10.5
 * Manifest List: Yes
 * Supported platforms: # TODO update this list
```

### Usage example

Default working directory is `/mount`:

```bash
$ docker run --rm -v "$(pwd):/mount" \
    ghcr.io/tarampampam/evans:0.10.5 \
      --path ./path/to/dir/with/proto/files \
      --proto file-name.proto \
      --host example.com \
      --port 50051 \
      repl
```

> **Important notice**: by default processes in docker image will be run using **unprivileged** user. If you will have any problems with this (for example - writing something in mounted volumes will fails) you may use `docker run ... --user 0:0 ...` argument.

## Releasing

New versions publishing is very simple - just "publish" new release using repo releases page. Release version should be same as the evans version.

## License

WTFPL. Use anywhere for your pleasure.

[evans]:https://github.com/ktr0731/evans
[ghcr]:https://github.com/tarampampam/evans-docker/pkgs/container/evans
