<p align="center">
  <img src="https://socialify.git.ci/tarampampam/evans-docker/image?forks=1&issues=1&owner=1&stargazers=1&theme=Dark" alt="" width="100%" />
</p>

<p align="center">
  <img src="https://img.shields.io/github/workflow/status/tarampampam/evans-docker/tests?maxAge=30&label=tests&logo=github&style=flat-square" alt="" />
  <img src="https://img.shields.io/github/workflow/status/tarampampam/evans-docker/release?maxAge=30&label=release&logo=github&style=flat-square" alt="" />
  <img src="https://img.shields.io/github/license/tarampampam/evans-docker.svg?maxAge=30&style=flat-square" alt="" />
</p>

## What includes this image?

Docker image with [evans][evans]. Documentation can be found [here][evans]. Quick usage help:

```shell
$ evans -h
evans 0.10.6

Usage: evans [global options ...] <command>

Options:
        --silent, -s               hide redundant output (default "false")
        --path strings             comma-separated proto file paths (default "[]")
        --proto strings            comma-separated proto file names (default "[]")
        --host string              gRPC server host
        --port, -p string          gRPC server port (default "50051")
        --header slice of strings  default headers that set to each requests (example: foo=bar) (default "[]")
        --web                      use gRPC-Web protocol (default "false")
        --reflection, -r           use gRPC reflection (default "false")
        --tls, -t                  use a secure TLS connection (default "false")
        --cacert string            the CA certificate file for verifying the server
        --cert string              the certificate file for mutual TLS auth. it must be provided with --certkey.
        --certkey string           the private key file for mutual TLS auth. it must be provided with --cert.
        --servername string        override the server name used to verify the hostname (ignored if --tls is disabled)
        --edit, -e                 edit the project config file by using $EDITOR (default "false")
        --edit-global              edit the global config file by using $EDITOR (default "false")
        --verbose                  verbose output (default "false")
        --version, -v              display version and exit (default "false")
        --help, -h                 display help text and exit (default "false")

Available Commands:
        cli         CLI mode
        repl        REPL mode
```

## Docker image

| Registry                          | Image                       |
|-----------------------------------|-----------------------------|
| [GitHub Container Registry][ghcr] | `ghcr.io/tarampampam/evans` |

All supported image tags [can be found here](https://github.com/tarampampam/evans-docker/pkgs/container/evans/versions).

Following platforms for this image are available:

```shell
$ docker run --rm mplatform/mquery ghcr.io/tarampampam/evans:latest
Image: ghcr.io/tarampampam/evans:latest
 * Manifest List: Yes
 * Supported platforms:
   - linux/386
   - linux/amd64
   - linux/arm64
   - linux/arm/v6
```

### Usage examples

Default working directory is `/mount`:

```shell
$ docker run --rm -v "$(pwd):/mount:ro" \
    ghcr.io/tarampampam/evans:latest \
      --path ./path/to/dir/with/proto/files \
      --proto file-name.proto \
      --host example.com \
      --port 50051 \
      repl
```

Or you can use `docker-compose`:

```yaml
version: '3.4'

services:
  app:
    # ...
    ports:
      - '50051:50051/tcp'
    #healthcheck:
    #  test: ['CMD', '/healthcheck', 'command', 'here']
    #  interval: 4s
    #  timeout: 1s
    #  start_period: 5s

  evans:
    image: ghcr.io/tarampampam/evans:latest
    volumes:
      - .:/mount:ro
    #depends_on:
    #  app: {condition: service_healthy}
```

```shell
$ docker-compose run evans --path ./path/to/dir/with/proto/files --proto file-name.proto --host app --port 50051 repl
```

One more option is to put the following code in your shell initialization script (`~/.profile`, `~/.bashrc`):

```bash
function evans() { # https://github.com/tarampampam/evans-docker#usage-example
  docker run --rm -it \
    -v "$(pwd):/mount:ro" \
    ghcr.io/tarampampam/evans:latest $@
}
```

```shell
$ evans -v
evans 0.10.6
```

## Releasing

New versions publishing is very simple - just "publish" new release using repo releases page. Release version should be same as the evans version.

## License

WTFPL. Use anywhere for your pleasure.

[evans]:https://github.com/ktr0731/evans
[ghcr]:https://github.com/tarampampam/evans-docker/pkgs/container/evans
