# syntax=docker/dockerfile:1.2

FROM alpine:latest as builder

# renovate: source=github-tags name=ktr0731/evans
ARG EVANS_VERSION=0.10.6

RUN set -x \
    && export apkArch="$(apk --print-arch)" \
    && case "$apkArch" in \
        armhf) DIST_ARCHIVE_FILE_NAME='evans_linux_arm.tar.gz' ;; \
        aarch64) DIST_ARCHIVE_FILE_NAME='evans_linux_arm64.tar.gz' ;; \
        x86_64) DIST_ARCHIVE_FILE_NAME='evans_linux_amd64.tar.gz' ;; \
        x86) DIST_ARCHIVE_FILE_NAME='evans_linux_386.tar.gz' ;; \ 
        *) echo >&2 "error: unsupported architecture: $apkArch"; exit 1 ;; \
    esac \
    && wget -O /tmp/dist.tar.gz "https://github.com/ktr0731/evans/releases/download/v$EVANS_VERSION/$DIST_ARCHIVE_FILE_NAME" \
    && mkdir /tmp/dist \
    && tar -xvzf /tmp/dist.tar.gz -C /tmp/dist \
    && /tmp/dist/evans --version

WORKDIR /tmp/rootfs

# prepare the rootfs for scratch
RUN set -x \
    && mkdir -p ./bin ./etc/ssl ./tmp ./mount ./.config/evans ./.cache \
    && mv /tmp/dist/evans ./bin/evans \
    && echo 'evans:x:10001:10001::/tmp:/sbin/nologin' > ./etc/passwd \
    && echo 'evans:x:10001:' > ./etc/group \
    && cp -R /etc/ssl/certs ./etc/ssl/certs \
    && chown -R 10001:10001 ./.config ./.cache \
    && chmod -R 777 ./tmp ./mount ./.config ./.cache

# use empty filesystem
FROM scratch as runtime

LABEL \
    # Docs: <https://github.com/opencontainers/image-spec/blob/master/annotations.md>
    org.opencontainers.image.title="evans" \
    org.opencontainers.image.description="Docker image with evans - more expressive universal gRPC client" \
    org.opencontainers.image.url="https://github.com/tarampampam/evans-docker" \
    org.opencontainers.image.source="https://github.com/tarampampam/evans-docker" \
    org.opencontainers.image.vendor="tarampampam" \
    org.opencontainers.image.licenses="WTFPL"

# use an unprivileged user
USER 10001:10001

# import from builder
COPY --from=builder /tmp/rootfs /

WORKDIR "/mount"

ENTRYPOINT ["/bin/evans"]
