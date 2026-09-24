FROM node:22-bookworm-slim
WORKDIR /app

COPY safecheck.part01a safecheck.part01b safecheck.part02 safecheck.part03 safecheck.part04 safecheck.part05 safecheck.part06 safecheck.part07 /tmp/

RUN cat /tmp/safecheck.part01a /tmp/safecheck.part01b /tmp/safecheck.part02 /tmp/safecheck.part03 /tmp/safecheck.part04 /tmp/safecheck.part05 /tmp/safecheck.part06 /tmp/safecheck.part07 > /tmp/safecheck.tar.gz.b64 \
 && node -e "const fs=require('fs'); const s=fs.readFileSync('/tmp/safecheck.tar.gz.b64','utf8').replace(/\\s+/g,''); fs.writeFileSync('/tmp/safecheck.tar.gz',Buffer.from(s,'base64'));" \
 && tar -tzf /tmp/safecheck.tar.gz >/dev/null \
 && tar -xzf /tmp/safecheck.tar.gz -C /app \
 && rm -f /tmp/safecheck.part* /tmp/safecheck.tar.gz.b64 /tmp/safecheck.tar.gz \
 && mkdir -p /data \
 && chown -R node:node /app /data

USER node
ENV NODE_ENV=production PORT=8080 DATA_DIR=/data
EXPOSE 8080
CMD ["node","server/server.mjs"]
