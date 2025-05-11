# Стадия сборки
FROM node:18-slim AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .

# Производственная стадия
FROM node:18-slim
WORKDIR /app
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app ./
ENV N8N_PORT=5678
ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=http
ENV N8N_USER_FOLDER=/data
EXPOSE 5678
CMD ["n8n", "start"]