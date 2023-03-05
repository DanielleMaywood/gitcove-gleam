FROM mcr.microsoft.com/devcontainers/base:bullseye

ARG GLEAM_VERSION="v0.27.0"
ARG GLEAM_TARGET="unknown-linux-musl"
ARG GLEAM_ARCH="x86_64"
ARG GLEAM_SHA256="353414ca065fd3338945195341e553d137e2be42838359cac758f43199b20107"
ARG GLEAM_URL="https://github.com/gleam-lang/gleam/releases/download/${GLEAM_VERSION}/gleam-${GLEAM_VERSION}-${GLEAM_ARCH}-${GLEAM_TARGET}.tar.gz"

ARG DENO_VERSION="v1.31.1"
ARG DENO_TARGET="unknown-linux-gnu"
ARG DENO_ARCH="x86_64"
ARG DENO_SHA256="40b9d50630f9668a7a72d01d68b61723cc659194c13e9555641ac2ab6273bc0f"
ARG DENO_URL="https://github.com/denoland/deno/releases/download/${DENO_VERSION}/deno-${DENO_ARCH}-${DENO_TARGET}.zip"

RUN wget -O /tmp/gleam.tar.gz "${GLEAM_URL}" && \
    echo "${GLEAM_SHA256}  /tmp/gleam.tar.gz" | sha256sum -c && \
    tar xf /tmp/gleam.tar.gz -C /usr/local/bin && \
    rm /tmp/gleam.tar.gz && \
    wget -O /tmp/deno.zip "${DENO_URL}" && \
    echo "${DENO_SHA256}  /tmp/deno.zip" | sha256sum -c && \
    unzip /tmp/deno.zip -d /usr/local/bin
