# Étape 1 : Build des dépendances
FROM node:18-alpine AS build-stage
WORKDIR /app

COPY package*.json ./
RUN npm ci --production

COPY . .

# Étape 2 : Image de production
FROM node:18-alpine AS production
WORKDIR /app

COPY --from=build-stage /app /app

# Création d'un utilisateur sécurisé
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3001
CMD ["sh", "-c", "node src/app.js"]