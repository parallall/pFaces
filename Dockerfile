FROM ubuntu:24.04
LABEL maintainer="Mahmoud Khaled <eng.mk@msn.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV LANG=C.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    unzip \
    build-essential \
    cmake \
    git \
    opencl-headers \
    ocl-icd-opencl-dev \
    pocl-opencl-icd \
    clinfo \
    && rm -rf /var/lib/apt/lists/*

# Install pFaces v1.5 release
RUN curl -sL https://github.com/parallall/pFaces/releases/download/v1.5.0/pFaces-1.5-Ubuntu22.04.5LTS-x86_64.zip -o /tmp/pfaces.zip \
    && mkdir -p /opt/pfaces \
    && unzip -q /tmp/pfaces.zip -d /opt/pfaces \
    && rm /tmp/pfaces.zip \
    && cd /opt/pfaces && sh ./install.sh

ENV PFACES_ROOT=/opt/pfaces
ENV PFACES_SDK_ROOT=/opt/pfaces/pfaces-sdk
ENV PATH="/opt/pfaces/bin:${PATH}"

WORKDIR /workspace

CMD ["pfaces", "-h"]
