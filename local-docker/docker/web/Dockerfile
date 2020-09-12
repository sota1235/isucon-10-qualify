FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY mime.types /etc/nginx/mime.types
COPY isucon.conf /etc/nginx/conf.d/isucon.conf
RUN rm /etc/nginx/conf.d/default.conf
ADD data /www/data

EXPOSE 80