FROM node:22-bookworm-slim
WORKDIR /app

COPY safecheck.part01 safecheck.part02 safecheck.part03 safecheck.part04 safecheck.part05 safecheck.part06 safecheck.part07 /tmp/

RUN cat /tmp/safecheck.part01 /tmp/safecheck.part02 /tmp/safecheck.part03 /tmp/safecheck.part04 /tmp/safecheck.part05 /tmp/safecheck.part06 /tmp/safecheck.part07 > /tmp/safecheck.tar.gz.b64 \
 && base64 -d /tmp/safecheck.tar.gz.b64 > /tmp/safecheck.tar.gz \
 && echo "8bf9e2540bf5f9c10cd720e437d0057e3c5488a7b0f86c2a734445e32e246a75  /tmp/safecheck.tar.gz" | sha256sum -c - \
 && tar -xzf /tmp/safecheck.tar.gz -C /app \
 && rm -f /tmp/safecheck.part* /tmp/safecheck.tar.gz.b64 /tmp/safecheck.tar.gz \
 && mkdir -p /data \
 && chown -R node:node /app /data

USER node
ENV NODE_ENV=production PORT=8080 DATA_DIR=/data
EXPOSE 8080
CMD ["node","server/server.mjs"]
