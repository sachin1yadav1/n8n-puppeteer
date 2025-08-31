// Puppeteer Scraper + API for n8n
const express = require("express");
const puppeteer = require("puppeteer");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/scrape", async (req, res) => {
  const targetUrl =
    req.query.url ||
    "https://www.google.com/maps/search/marketing+agency+california";

  let browser;
  try {
    // Launch Chromium with proper flags for Docker
    browser = await puppeteer.launch({
      headless: true,
      executablePath:
        process.env.PUPPETEER_EXECUTABLE_PATH || "/usr/bin/chromium",
      args: [
        "--no-sandbox",
        "--disable-setuid-sandbox",
        "--disable-dev-shm-usage", // Fix low /dev/shm memory issues
        "--disable-gpu",
        "--disable-software-rasterizer",
      ],
      protocolTimeout: 120000, // 2 mins instead of 30s default
    });

    const page = await browser.newPage();

    const logs = [];
    page.on("request", (request) => {
      logs.push({
        url: request.url(),
        method: request.method(),
        headers: request.headers(),
        postData: request.postData() || null,
      });
    });

    console.log(`🌍 Navigating to ${targetUrl}...`);

    await page.goto(targetUrl, {
      waitUntil: "networkidle2",
      timeout: 120000, // increase navigation timeout
    });

    console.log("📜 Scrolling page...");
    for (let i = 0; i < 5; i++) {
      await page.evaluate(() => window.scrollBy(0, window.innerHeight));
      await page.waitForTimeout(2000);
    }

    console.log("✅ Scrape complete.");
    res.json({ success: true, url: targetUrl, requests: logs });
  } catch (err) {
    console.error("❌ Puppeteer error:", err.message);
    res.status(500).json({ success: false, error: err.message });
  } finally {
    if (browser) {
      await browser.close();
      console.log("🔒 Browser closed.");
    }
  }
});

app.listen(PORT, () =>
  console.log(`🚀 Puppeteer API running on port ${PORT}`)
);
