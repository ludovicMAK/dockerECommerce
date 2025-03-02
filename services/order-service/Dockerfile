FROM node:18-alpine AS build-stage
WORKDIR /app

COPY package*.json ./
RUN npm ci --production

COPY . .

FROM node:18-alpine AS production
WORKDIR /app
COPY --from=build-stage /app /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3002
CMD ["node", "src/app.js"]
