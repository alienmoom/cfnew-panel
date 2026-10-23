FROM node:22-alpine
WORKDIR /app
COPY --chown=node:node src ./src
COPY --chown=node:node package.json LICENSE NOTICE.md ./
USER node
ENV HOST=0.0.0.0 PORT=3100 NODE_ENV=production
EXPOSE 3100 3000


CMD ["sh", "-c", "trap '' TERM INT; while true; do node --max-old-space-size=256 src/server.mjs 2>&1; echo \"[WATCHDOG] node exited ($?), restarting...\"; sleep 1; done"]
