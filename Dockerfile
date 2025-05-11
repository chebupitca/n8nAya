# Используем версию Node.js, соответствующую требованиям
FROM node:20.15-slim

# Устанавливаем pnpm
RUN npm install -g pnpm@10.2.1

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы проекта
COPY package*.json ./
COPY . .

# Устанавливаем зависимости с помощью pnpm
RUN pnpm install --production

# Устанавливаем переменные окружения для n8n
ENV N8N_PORT=5678
ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=http
ENV N8N_USER_FOLDER=/data

# Открываем порт
EXPOSE 5678

# Запускаем n8n из правильной директории
CMD ["sh", "-c", "cd packages/cli/bin && ./n8n start"]