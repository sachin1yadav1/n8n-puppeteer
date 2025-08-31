FROM n8nio/n8n:latest

USER root

# Install Chromium and dependencies
RUN apk update && apk add --no-cache \
    chromium \
    chromium-chromedriver \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    wget \
    curl \
    xvfb \
    nodejs \
    npm \
    git

# Puppeteer needs chromium path
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Install Puppeteer and force Chrome download
RUN npm install -g puppeteer@22.15.0 \
    && PUPPETEER_SKIP_DOWNLOAD=false \
    && npx puppeteer browsers install chrome

# Switch back to node user
USER node

# Healthcheck for Coolify
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:5678/healthz || exit 1
