FROM debian:trixie-slim

# Runtime for nftset tests, plus toolchain so nginz is built inside the image
# (host-built binaries are not portable across distro glibc/sonames).
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    ca-certificates \
    findutils \
    nftables \
    xz-utils \
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
    && rm -rf /var/lib/apt/lists/*

# Official Zig 0.16.0 tarball — self-contained, pinned for reproducible container builds.
ARG ZIG_VERSION=0.16.0
ARG ZIG_ARCH=x86_64
RUN curl -fsSL "https://ziglang.org/download/${ZIG_VERSION}/zig-${ZIG_ARCH}-linux-${ZIG_VERSION}.tar.xz" \
    | tar -xJ -C /opt \
    && mv "/opt/zig-${ZIG_ARCH}-linux-${ZIG_VERSION}" /opt/zig \
    && ln -sf /opt/zig/zig /usr/local/bin/zig \
    && zig version

WORKDIR /workdir

CMD ["sleep", "infinity"]
