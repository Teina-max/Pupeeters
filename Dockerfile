# n8n (base Alpine dans ton build)
FROM n8nio/n8n:latest

USER root

# Dépendances système pour Chromium/Puppeteer (Alpine)
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Installer Puppeteer globalement
RUN npm install -g puppeteer@21.0.0

# Empêcher le téléchargement auto de Chromium par Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Sur Alpine, le binaire est généralement chromium-browser (alias vers chromium)
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Autoriser l'import dans les Function nodes n8n
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer

# (Optionnel) Flags utiles en conteneur
ENV PUPPETEER_ARGS="--no-sandbox --disable-setuid-sandbox"

USER node
