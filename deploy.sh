docker login $DOCKER_REGISTRY -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker compose --env-file .env.production -f docker-compose.prod.yml up -d
