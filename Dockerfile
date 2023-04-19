#== First stage: this is the build stage for Substrate. Here we create the binary.
FROM docker.io/paritytech/ci-linux:production as builder

WORKDIR /eightfish
COPY . .
RUN cargo build --locked --release

# install rust components
RUN rustup target add wasm32-wasi

# install third tools
RUN cd /tmp/ && curl -fsSL https://developer.fermyon.com/downloads/install.sh | bash && mv spin /usr/local/bin/
RUN cargo install subxt-cli && cargo install hurl

#== Second stage: 