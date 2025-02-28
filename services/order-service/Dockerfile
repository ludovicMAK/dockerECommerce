FROM node:18-alpine as build-stage
WORKDIR /app

COPY package.json ./
RUN npm install --production --frozen-lockfile

COPY . .

FROM node:18-alpine
WORKDIR /app
COPY --from=build-stage /app /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3002
CMD ["node", "src/app.js"]
