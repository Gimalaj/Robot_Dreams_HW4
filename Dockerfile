FROM ubuntu:latest
RUN apt update 
RUN apt upgrade -y 
RUN apt install -y nginx
RUN apt install -y curl htop pwgen
COPY index.html /var/www/html/
CMD ["nginx", "-g", "daemon off;"]