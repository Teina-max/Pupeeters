# Image officielle n8n (Debian)
FROM n8nio/n8n:latest

USER root

# Dépendances pour Chromium/Puppeteer
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ca-certificates \
      chromium \
      chromium-sandbox \
      fonts-liberation \
      libnss3 \
      libatk1.0-0 \
      libatk-bridge2.0-0 \
      libx11-6 \
      libxcomposite1 \
      libxdamage1 \
      libxext6 \
      libxfixes3 \
      libxrandr2 \
      libgbm1 \
      libasound2 \
      libpangocairo-1.0-0 \
      libpango-1.0-0 \
      libcairo2 \
      libatspi2.0-0 \
      libdrm2 \
      libx11-xcb1 \
    && rm -rf /var/lib/apt/lists/*

# Puppeteer global (pour require('puppeteer') en runtime)
RUN npm install -g puppeteer@21.0.0

# Empêcher le download auto de Chromium par Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
# Chemin du binaire Chromium (Debian)
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Autoriser l'import dans les Function nodes n8n
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer

# (Optionnel) améliorer la stabilité de Chromium en conteneur
ENV PUPPETEER_ARGS="--no-sandbox --disable-setuid-sandbox"

USER node
