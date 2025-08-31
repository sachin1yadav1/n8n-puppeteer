FROM n8nio/n8n:latest

USER root

# Install Chromium & Puppeteer dependencies (Alpine packages)
RUN apk update && apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    wget \
    xvfb

# Set the Chrome executable path (for Puppeteer)
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Install Puppeteer
RUN npm install -g puppeteer

USER node
