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
    xvfb

# Puppeteer needs chromium path
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Install Puppeteer globally
RUN npm install -g puppeteer

USER node

# ✅ Ensure container runs n8n correctly
CMD ["n8n"]
