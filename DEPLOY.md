# Guide de déploiement Firebase Hosting

Ce guide vous explique comment déployer votre application Flutter sur Firebase Hosting.

## Prérequis

1. **Flutter** installé et configuré
2. **Firebase CLI** installé globalement :
   ```bash
   npm install -g firebase-tools
   ```

3. **Connexion à Firebase** :
   ```bash
   firebase login
   ```

## Configuration

La configuration Firebase est déjà en place :
- ✅ `.firebaserc` - Configuration du projet (innocent-konan)
- ✅ `firebase.json` - Configuration du hosting
- ✅ `.firebaseignore` - Fichiers à ignorer lors du déploiement

## Déploiement

### Méthode 1 : Script automatique (recommandé)

```bash
./deploy.sh
```

Options disponibles :
- `./deploy.sh --only-build` : Construire uniquement l'application
- `./deploy.sh --only-deploy` : Déployer uniquement (sans rebuild)

### Méthode 2 : Commandes manuelles

1. **Construire l'application Flutter pour le web** :
   ```bash
   flutter clean
   flutter pub get
   flutter build web --release
   ```

2. **Déployer sur Firebase Hosting** :
   ```bash
   firebase deploy --only hosting
   ```

### Méthode 3 : Déploiement avec message

```bash
firebase deploy --only hosting --message "Description de votre déploiement"
```

## Vérification

Après le déploiement, votre application sera accessible à :
- URL par défaut : `https://innocent-konan.web.app`
- URL personnalisée : `https://innocent-konan.firebaseapp.com`

## Commandes utiles

- **Voir l'historique des déploiements** :
  ```bash
  firebase hosting:channel:list
  ```

- **Créer un canal de prévisualisation** :
  ```bash
  firebase hosting:channel:deploy preview-channel
  ```

- **Annuler le dernier déploiement** :
  ```bash
  firebase hosting:rollback
  ```

## Configuration actuelle

- **Dossier public** : `build/web`
- **Routing SPA** : Toutes les routes redirigent vers `/index.html`
- **Cache** : 7 jours pour les assets statiques
- **URLs propres** : Activées (`cleanUrls: true`)

## Dépannage

Si vous rencontrez des erreurs :

1. **Vérifier la connexion Firebase** :
   ```bash
   firebase projects:list
   ```

2. **Vérifier la configuration** :
   ```bash
   firebase hosting:sites:list
   ```

3. **Nettoyer et reconstruire** :
   ```bash
   flutter clean
   flutter pub get
   flutter build web --release
   ```
