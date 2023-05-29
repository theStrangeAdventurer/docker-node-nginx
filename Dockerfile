FROM node:latest as builder

RUN apt-get update && apt-get install -y nginx

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

# Копируем конфиг из нашего кода, где описано проксирование на nodejs
COPY nginx.conf /etc/nginx/nginx.conf

# Выставляем наружу только 80 порт
EXPOSE 80

# Запускаем сразу и nodejs и nginx
CMD service nginx start && npm start
