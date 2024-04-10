FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG CARGO_REGISTRIES_RD_TOKEN

LABEL maintainer="Deniz Hofmeister"
LABEL description="Robotics Dashboard Device"

RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  gnupg \
  software-properties-common \
  curl \
  git \
  openssh-client \
  pkg-config \
  libssl-dev \
  build-essential \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV RUSTUP_HOME=/opt/rustup
ENV CARGO_HOME=/opt/cargo

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="/opt/cargo/bin:${PATH}"

RUN chmod -R 777 /opt/rustup \
  && chmod -R 777 /opt/cargo

COPY . /opt/device
WORKDIR /opt/device

RUN cp /opt/device/target/release/device /usr/bin/device && \
  mkdir -p /etc/rd && \
  cp -R /opt/device/tests/device_cfg.yaml /etc/rd/device.yaml && \
  cp -R /opt/device/tests/wireguard_cfg.yaml /etc/rd/wireguard.yaml

CMD ["bash"]
