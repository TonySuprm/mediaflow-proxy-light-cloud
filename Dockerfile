# MediaFlow Proxy Light — cloud deploy image.
# Wraps the existing public image (no changes to the proxy itself) so it:
#   - binds 0.0.0.0 on the platform-assigned $PORT (Render/Railway requirement)
#   - takes its API password from the API_PASSWORD env var
#
# NOTE: tonysupr/mediaflow-proxy-light is a distroless image (just the Rust
# binary, no shell), so the wrapper stages the binary onto debian:bookworm-slim.
FROM tonysupr/mediaflow-proxy-light:latest AS proxy
FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=proxy /app/mediaflow-proxy-light /usr/local/bin/mediaflow-proxy-light
COPY mediaflow-deploy.toml /app/mediaflow-deploy.toml
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

ENTRYPOINT ["/app/start.sh"]
