# Étape 1 : Build de l'application Vue.js
FROM node:18-alpine AS build-stage
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install --frozen-lockfile

COPY . .
RUN npm run build

# Étape 2 : Serveur Nginx pour la production
FROM nginx:1.23-alpine AS production-stage
WORKDIR /etc/nginx/conf.d

# Ajout du fichier de configuration Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copie des fichiers statiques du frontend
WORKDIR /usr/share/nginx/html
COPY --from=build-stage /app/dist .

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
