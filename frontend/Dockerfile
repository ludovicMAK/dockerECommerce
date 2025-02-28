# Étape 1 : Build de l'application Vue.js
FROM node:18-alpine AS build-stage
WORKDIR /app

# Installer les dépendances nécessaires pour le build
RUN apk add --no-cache python3 make g++

# Copier les fichiers de dépendances
COPY package*.json ./
RUN npm install

# Copier le reste des fichiers
COPY . .

# Build de l'application
RUN npm run build

# Étape 2 : Serveur Nginx pour la production
FROM nginx:1.23-alpine AS production-stage

# Installer des outils de débogage
RUN apk add --no-cache curl

# Copier la configuration Nginx personnalisée
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copier les fichiers statiques du frontend
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Vérifier que les fichiers sont bien copiés
RUN ls -la /usr/share/nginx/html

# Vérifier la configuration nginx
RUN nginx -t

EXPOSE 80

# Démarrer Nginx en mode debug
CMD ["nginx", "-g", "daemon off;error_log /dev/stdout debug;"]
