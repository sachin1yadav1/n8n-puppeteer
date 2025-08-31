# Start from official n8n image
FROM n8nio/n8n:latest

# Switch to root to install system deps
USER root

# Install Chromium and Puppeteer dependencies
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    fonts-liberation \
    libappindicator3-1 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libxshmfence1 \
    wget \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Install Puppeteer globally
RUN npm install -g puppeteer

# Switch back to node user for security
USER node
