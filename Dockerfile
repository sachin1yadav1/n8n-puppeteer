FROM n8nio/n8n:latest

USER root

# Install Chromium & Puppeteer dependencies (Alpine)
RUN apk update && apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    wget \
    curl \
    xvfb

# Puppeteer needs chromium path
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Install Puppeteer globally
RUN npm install -g puppeteer

USER node

# ✅ Healthcheck for Coolify
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:5678/healthz || exit 1

# ✅ Explicitly run n8n
CMD ["n8n"]
