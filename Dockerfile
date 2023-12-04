FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY package*.json ./

COPY app.js ./

EXPOSE 4000

