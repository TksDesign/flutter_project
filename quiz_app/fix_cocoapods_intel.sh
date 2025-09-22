#!/bin/bash

# Vérifie que le script est lancé depuis le dossier racine du projet Flutter
if [ ! -f "pubspec.yaml" ]; then
  echo "⚠️  Ce script doit être exécuté depuis la racine de votre projet Flutter."
  exit 1
fi

echo "🧹 Suppression de toutes les versions de ffi..."
sudo gem uninstall ffi --all --executables

echo "📦 Réinstallation de ffi pour l'architecture Intel..."
sudo arch -x86_64 gem install ffi

echo "📦 Réinstallation de CocoaPods pour l'architecture Intel..."
sudo arch -x86_64 gem install cocoapods

echo "🔍 Vérification et modification du Podfile..."
cd ios
if ! grep -q "^platform :ios" Podfile; then
  echo "Ajout de 'platform :ios, '12.0'' dans le Podfile..."
  sed -i '' '1s/^/platform :ios, '\''12.0'\''\n/' Podfile
else
  echo "✅ Plateforme déjà définie dans le Podfile."
fi

echo "🧼 Nettoyage des anciens pods..."
rm -rf Pods Podfile.lock

echo "🚀 Installation des pods avec la bonne architecture..."
arch -x86_64 pod install

cd ..

echo "🧹 Nettoyage Flutter et récupération des packages..."
flutter clean
flutter pub get

echo "✅ Terminé ! Tu peux maintenant relancer ton projet Flutter iOS."

