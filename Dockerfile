# --- Stage 1: Build Flutter Web ---
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app
COPY . .

# Build Flutter Web for production
RUN flutter build web --release


# --- Stage 2: Serve using Nginx ---
FROM nginx:alpine

# Copy build files to Nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
