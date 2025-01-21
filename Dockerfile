FROM node:21 as builder

WORKDIR /app

COPY . .

RUN npm install

RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
# COPY .htaccess /usr/share/nginx/html

# COPY mime.types /etc/nginx/mime.types

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
