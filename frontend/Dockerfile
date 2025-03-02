# Étape 1 : Build
FROM node:18-alpine AS build-stage
WORKDIR /app

# Installation des dépendances nécessaires pour le build
RUN apk add --no-cache python3 make g++

# Copier les fichiers de dépendances
COPY package*.json ./

# Installation des dépendances
RUN npm install && \
    npm install --no-save @rollup/rollup-linux-x64-musl@4.6.1

# Copier le reste des fichiers
COPY . .

# Build de l'application
RUN npm run build

# Étape 2 : Production
FROM nginx:1.23-alpine AS production-stage

# Créer un utilisateur non-root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copier la configuration nginx et les fichiers buildés
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Changer les permissions
RUN chown -R appuser:appgroup /usr/share/nginx/html && \
    chown -R appuser:appgroup /var/cache/nginx && \
    chown -R appuser:appgroup /var/log/nginx && \
    chown -R appuser:appgroup /etc/nginx/conf.d && \
    touch /var/run/nginx.pid && \
    chown -R appuser:appgroup /var/run/nginx.pid

USER appuser

# Vérification de la configuration
RUN nginx -t

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
