FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html
COPY pictures/web /usr/share/nginx/html/pictures/web

EXPOSE 80
