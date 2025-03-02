#!/bin/sh

# Attendre que le service product soit disponible
echo "Attente du service product..."
sleep 10

# Initialisation des produits via l'API
echo "Initialisation des produits..."

curl -X POST http://localhost:3000/api/products -H "Content-Type: application/json" -d '{
  "name": "Smartphone Galaxy S21",
  "price": 899,
  "description": "Dernier smartphone Samsung avec appareil photo 108MP",
  "stock": 15
}'

curl -X POST http://localhost:3000/api/products -H "Content-Type: application/json" -d '{
  "name": "MacBook Pro M1",
  "price": 1299,
  "description": "Ordinateur portable Apple avec puce M1",
  "stock": 10
}'

curl -X POST http://localhost:3000/api/products -H "Content-Type: application/json" -d '{
  "name": "PS5",
  "price": 499,
  "description": "Console de jeu dernière génération",
  "stock": 5
}'

echo "Initialisation terminée!"