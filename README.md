# MediaFlow Proxy Light (cloud)

Wraps the public `tonysupr/mediaflow-proxy-light` image for cloud hosting
(**Render** or **Railway**) so a phone-hosted Aetheria Link addon can use it
via `MEDIA_FLOW_PROXY_URL` from anywhere. The proxy itself is unchanged.

## Deploy on Railway

1. Railway → New Project → Deploy from GitHub repo → pick this repo.
2. Railway auto-detects the `Dockerfile` (also declared in `railway.toml`).
3. Set the environment variable: `API_PASSWORD` = a strong secret.
4. After deploy, copy the public domain, e.g. `https://mediaflow-proxy-light-cloud-production.up.railway.app`.
5. In Aeth Online (or any Stremio addon config), set:
   `MEDIA_FLOW_PROXY_URL = https://<that-domain>` and
   `MEDIA_FLOW_PROXY_PASSWORD = <your API_PASSWORD>`.

## Deploy on Render

1. Render → New + → Blueprint → point at this repo (uses `render.yaml`).
2. Set `API_PASSWORD` when prompted.
3. Use the assigned `onrender.com` domain the same way.

## Notes

- The container listens on the platform-assigned `$PORT` (handled in `start.sh`).
- Free Render instances sleep after ~15 min idle: the first stream after a nap
  is slow. Railway starter plans stay on.
- Health check: `GET /` (200 once the proxy is up).
- Verify with: `curl "https://<domain>/?password=<API_PASSWORD>"` (200 = OK).
