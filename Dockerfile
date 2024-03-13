FROM --platform=${TARGETPLATFORM} debian:latest
LABEL maintainer="V2Fly Community <dev@v2fly.org>"

WORKDIR /tmp
ARG TARGETPLATFORM
ARG TAG
COPY v2ray.sh "${WORKDIR}"/v2ray.sh

RUN apt-get update \
    && apt-get install -y ca-certificates wget \
    && mkdir -p /etc/v2ray /usr/local/share/v2ray /var/log/v2ray \
    && ln -sf /dev/stdout /var/log/v2ray/access.log \
    && ln -sf /dev/stderr /var/log/v2ray/error.log \
    && chmod +x "${WORKDIR}"/v2ray.sh \
    && "${WORKDIR}"/v2ray.sh "${TARGETPLATFORM}" "${TAG}" \
    && apt-get remove -y wget \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/v2ray"]
