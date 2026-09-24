FROM node:22-bookworm-slim
WORKDIR /app
COPY safecheck.tar.gz.b64 /tmp/safecheck.tar.gz.b64
RUN base64 -d /tmp/safecheck.tar.gz.b64 > /tmp/safecheck.tar.gz \
 && tar -xzf /tmp/safecheck.tar.gz -C /app --strip-components=1 \
 && rm /tmp/safecheck.tar.gz /tmp/safecheck.tar.gz.b64 \
 && mkdir -p /data \
 && chown -R node:node /app /data
USER node
ENV NODE_ENV=production PORT=8080 DATA_DIR=/data
EXPOSE 8080
CMD ["node","server/server.mjs"]
