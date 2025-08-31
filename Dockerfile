FROM node:18-alpine

# Install Chromium + dependencies
RUN apk add --no-cache chromium nss freetype harfbuzz ca-certificates ttf-freefont wget curl xvfb

# Set Puppeteer to use system Chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000
CMD ["node", "scraper.js"]
