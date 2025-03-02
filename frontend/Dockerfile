# Étape 1 : Build
FROM node:18-alpine AS build-stage
WORKDIR /app

# Installation des dépendances nécessaires pour le build
RUN apk add --no-cache python3 make g++

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer rollup explicitement pour Alpine
RUN npm ci && \
    npm install @rollup/rollup-linux-x64-musl

# Copier le reste des fichiers
COPY . .

# Build de l'application
RUN npm run build

# Étape 2 : Production
FROM nginx:1.23-alpine AS production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN nginx -t

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
