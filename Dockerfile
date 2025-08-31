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

# Switch back to node user
USER node
