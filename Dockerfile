# Build stage - install build dependencies
FROM debian:trixie-slim AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    xz-utils \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Zig 0.15.2
RUN zig_version="0.15.2" && \
    curl -kL "https://ziglang.org/download/${zig_version}/zig-x86_64-linux-${zig_version}.tar.xz" -o /tmp/zig.tar.xz && \
    tar -xf /tmp/zig.tar.xz -C /opt && \
    rm /tmp/zig.tar.xz && \
    ln -sf /opt/zig-x86_64-linux-${zig_version}/zig /usr/local/bin/zig && \
    ln -sf /opt/zig-x86_64-linux-${zig_version}/zig /usr/local/bin/zig++

# Install Bun for running tests
RUN curl -fsSL https://bun.sh/install | bash

# Runtime stage - minimal image
FROM debian:trixie-slim

# Only runtime dependencies needed
RUN apt-get update && apt-get install -y --no-install-recommends \
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

COPY --from=builder /opt/zig-x86_64-linux-0.15.2 /opt/zig-0.15.2
COPY --from=builder /root/.bun/bin/bun /usr/local/bin/bun
COPY --from=builder /usr/local/bin/zig /usr/local/bin/zig
COPY --from=builder /usr/local/bin/zig++ /usr/local/bin/zig++

ENV PATH="/opt/zig-0.15.2:${PATH}"

WORKDIR /workdir

CMD ["/bin/bash"]
