FROM ubuntu:22.04 AS builder

RUN apt-get update && apt-get -y install fuse2fs fdisk jq xz-utils
RUN mkdir out


ARG DATE=2024-03-15
ARG DEBIAN=bookworm
ARG IMAGE="${DATE}-raspios-${DEBIAN}-arm64-lite.img"

ADD https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-${DATE}/${IMAGE}.xz ${IMAGE}.xz

ADD mount-image.sh /
RUN /mount-image.sh out

FROM scratch


COPY --from=builder out /

CMD /bin/sh

ARG ORG=casaroli
ARG REPO=raspios-lite-docker-img

LABEL org.opencontainers.image.source https://github.com/${ORG}/${REPO}
