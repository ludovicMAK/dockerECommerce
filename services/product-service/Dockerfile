FROM node:18-alpine AS build-stage
WORKDIR /app

RUN apk --no-cache add curl

COPY package.json package-lock.json ./ 
RUN npm install --production --frozen-lockfile

COPY . .
COPY init-products.sh /app/init-products.sh

RUN chmod +x /app/init-products.sh

FROM node:18-alpine AS production
WORKDIR /app

RUN apk --no-cache add curl


COPY --from=build-stage /app /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3000
CMD ["sh", "-c", "/app/init-products.sh & node src/app.js"]