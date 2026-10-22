FROM node:22-alpine
WORKDIR /app
COPY --chown=node:node src ./src
COPY --chown=node:node package.json LICENSE NOTICE.md ./
USER node
ENV HOST=0.0.0.0 PORT=3100 NODE_ENV=production
EXPOSE 3100 3000
HEALTHCHECK --interval=5s --timeout=3s --start-period=2s --retries=3 \
  CMD node -e "fetch('http://127.0.0.1:3100/health').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"
CMD ["node", "src/server.mjs"]
