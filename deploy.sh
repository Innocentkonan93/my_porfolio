#!/bin/bash

# Script de déploiement Firebase Hosting pour Flutter
# Usage: ./deploy.sh [--only-build] [--only-deploy]

set -e

echo "🚀 Démarrage du déploiement..."

# Vérifier si Flutter est installé
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter n'est pas installé. Veuillez installer Flutter d'abord."
    exit 1
fi

# Vérifier si Firebase CLI est installé
if ! command -v firebase &> /dev/null; then
    echo "❌ Firebase CLI n'est pas installé."
    echo "📦 Installation de Firebase CLI..."
    npm install -g firebase-tools
fi

# Deploy to repo
deploy_repo() {
    echo "🚀 Déploiement sur GitHub..."
    git add .
    git commit -m "Deploy"
    git push
    echo "✅ Déploiement terminé avec succès!"
}

# Fonction pour build
build_flutter() {
    echo "🔨 Construction de l'application Flutter pour le web..."
    flutter clean
    flutter pub get
    flutter build web --release
    echo "✅ Build terminé avec succès!"
}

# Fonction pour déployer
deploy_firebase() {
    echo "🌐 Déploiement sur Firebase Hosting..."
    firebase deploy --only hosting
    echo "✅ Déploiement terminé avec succès!"
}

# Gestion des arguments
if [ "$1" == "--only-build" ]; then
    deploy_repo
    build_flutter
elif [ "$1" == "--only-deploy" ]; then
    deploy_repo
    deploy_firebase
else
    deploy_repo
    build_flutter
    deploy_firebase
fi

echo "🎉 Déploiement complet terminé!"
