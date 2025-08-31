# n8n + Puppeteer (Coolify Ready)

This repo builds a Docker image of **n8n** with **Puppeteer** pre-installed, so you can run browser automation inside your n8n workflows.

---

## 🚀 Deployment (Coolify)

1. Push this repo to GitHub/GitLab.
2. In **Coolify**:
   - Add Resource → Application → Git Repository
   - Repository URL: `https://github.com/yourname/n8n-puppeteer.git`
   - Branch: `main`
   - Dockerfile path: `./Dockerfile`
   - Port: `5678`
3. Add **persistent storage**:
   - Local Path: `/root/.n8n`
   - Container Path: `/home/node/.n8n`
4. Add **environment variables**:

```env
N8N_PORT=5678
N8N_PROTOCOL=https
WEBHOOK_URL=https://n8n.example.com/

# Security
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=yourStrongPassword

# Timezone
GENERIC_TIMEZONE=Asia/Kolkata
