# 🚀 Docker E-Commerce Project

## 🏗️ Architecture et bonnes pratiques

### 🌿 GitFlow
Notre projet utilise GitFlow comme stratégie de gestion des branches :
- 🏠 `main` : code de production
- 🔧 `develop` : branche de développement
- ✨ `feature/*` : nouvelles fonctionnalités
- 🚨 `hotfix/*` : corrections urgentes
- 📦 `release/*` : préparation des releases

### 📦 Multi-stage Build
Chaque service utilise un multi-stage build pour optimiser la taille des images :
- ⚙️ Phase de build : compilation et installation des dépendances
- 🚀 Phase de production : uniquement les fichiers nécessaires à l'exécution

### 🔐 Registry Privé
- 🛡️ Stockage sécurisé des images Docker
- 🔑 Configuration dans `.env` pour les credentials
- 🏷️ Images taguées avec le SHA du commit

### 🛠️ Orchestration avec Docker Compose
- 🏗️ `docker-compose.yml` : environnement de développement
- 🚀 `docker-compose.prod.yml` : environnement de production
- ⚙️ Variables d'environnement gérées via `.env`

### 🤖 CI/CD Pipeline
- ✅ Tests automatiques sur push vers `develop` et `main`
- 🏗️ Build et push des images vers le registry privé

#### 🔐 Configuration des secrets GitHub
Pour permettre à la CI d'accéder au registry privé, configurez les secrets suivants dans votre repository GitHub :

1. Allez dans `Settings > Secrets and variables > Actions`
2. Ajoutez les secrets suivants :
   - `REGISTRY_URL`: URL de votre registry privé
   - `REGISTRY_USERNAME`: Nom d'utilisateur du registry
   - `REGISTRY_PASSWORD`: Mot de passe du registry

Ces secrets seront utilisés dans les workflows GitHub Actions comme ceci :
```yaml
- name: Login to Private Registry
  uses: docker/login-action@v1
  with:
    registry: ${{ secrets.REGISTRY_URL }}
    username: ${{ secrets.REGISTRY_USERNAME }}
    password: ${{ secrets.REGISTRY_PASSWORD }}
```

### 🔒 Sécurité
- 👤 Utilisateur non-root dans les containers
- 🔑 Variables sensibles en environnement
- 🏗️ Images minimales en production

## 📥 Installation

### 💻 Développement
1. Cloner le repository
```bash
git clone https://github.com/ludovicMAK/dockerECommerce.git
cd dockerECommerce
```

2. Copier et configurer les variables d'environnement
```bash
cp .env.example .env
# ✏️ Éditer .env avec vos configurations
```

3. Lancer l'environnement de développement
```bash
docker compose -f docker-compose.yml up -d
```

### 🚢 Production
1. S'assurer d'avoir accès au registry privé
```bash
docker login <registry-url>
```

2. Configurer les variables d'environnement
```bash
cp .env.prod.example .env.prod
# ✏️ Éditer .env.prod avec les configurations de production
```

3. Déployer les services
```bash
docker compose -f docker-compose.prod.yml up -d
```