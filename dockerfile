# Usa Node per scaricare Astro e creare un progetto base al volo
FROM node:20-alpine AS builder
WORKDIR /app
RUN npm create astro@latest base-site -- --template starlight --no-install --no-git
WORKDIR /app/base-site
RUN npm install
RUN npm run build

# Passa i file a Nginx
FROM nginx:alpine
COPY --from=builder /app/base-site/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
