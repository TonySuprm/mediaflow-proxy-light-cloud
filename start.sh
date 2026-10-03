#!/bin/sh
# MediaFlow Proxy Light — cloud entrypoint (Render / Railway / any container host).
# Generates the runtime config from environment variables, then execs the proxy.
set -eu

PORT="${PORT:-8889}"
API_PASSWORD="${API_PASSWORD:-aetheria-link-secret}"
CONFIG="${CONFIG:-/app/mediaflow-runtime.toml}"

# Base = the tuned config shipped next to this script; override bind + auth.
cp /app/mediaflow-deploy.toml "$CONFIG"
sed -i "s/^host = .*/host = \"0.0.0.0\"/" "$CONFIG"
sed -i "s/^port = .*/port = ${PORT}/" "$CONFIG"
sed -i "s/^api_password = .*/api_password = \"${API_PASSWORD}\"/" "$CONFIG"

echo "[mediaflow-cloud] binding 0.0.0.0:${PORT} (password ${API_PASSWORD:+set})"
CONFIG_PATH="$CONFIG" exec /usr/local/bin/mediaflow-proxy-light
