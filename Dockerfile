# MediaFlow Proxy Light — cloud deploy image.
# Wraps the existing public image (no changes to the proxy itself) so it:
#   • binds 0.0.0.0 on the platform-assigned $PORT (Render/Railway requirement)
#   • takes its API password from the API_PASSWORD env var
FROM tonysupr/mediaflow-proxy-light:latest

COPY mediaflow-deploy.toml /app/mediaflow-deploy.toml
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

ENTRYPOINT ["/app/start.sh"]
