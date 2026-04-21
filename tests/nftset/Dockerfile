FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    nftables \
    patch \
    cmake \
    git \
    build-essential \
    libssl-dev \
    libpcre2-dev \
    zlib1g-dev \
    libgd-dev \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workdir

CMD ["sleep", "infinity"]
