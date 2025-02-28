FROM node:18-alpine AS build-stage
WORKDIR /app

RUN apk --no-cache add curl

# Copier les fichiers de dépendances
COPY services/product-service/package*.json ./
RUN npm install --production

# Copier le reste des fichiers de l'application
COPY services/product-service/src/ ./src/

# Copier le script d'initialisation depuis le dossier scripts
COPY scripts/init-products.sh /app/init-products.sh
RUN chmod +x /app/init-products.sh

# Étape de production
FROM node:18-alpine AS production
WORKDIR /app

RUN apk --no-cache add curl

# Copier les fichiers de l'étape de build
COPY --from=build-stage /app /app

# Créer un utilisateur non-root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3000

# Exécuter le script d'initialisation et démarrer l'application
CMD ["sh", "-c", "/app/init-products.sh & node src/app.js"]