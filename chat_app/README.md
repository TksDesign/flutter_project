# chat_app

A new Flutter project.

https://firebase.google.com/docs/reference/rest/auth

https://firebase.google.com/docs/flutter/setup?hl=fr&platform=ios

https://firebase.google.com/docs/cli?hl=fr#setup_update_cli

dart pub global activate flutterfire_cli
flutterfire configure
flutter pub add firebase_core
flutter pub add firebase_auth
flutterfire configure
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
runApp(const MainApp());
}

1. Prérequis
   Flutter installé et configuré
   Xcode à jour (minimum pour Swift 5.8+, recommandé 5.9)
   CocoaPods installé (sudo gem install cocoapods)
   Compte Firebase avec projet créé
2. Installation FlutterFire CLI
   Installer FlutterFire CLI :
   dart pub global activate flutterfire_cli
   Ajouter FlutterFire CLI au PATH :
   echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.zshrc
   source ~/.zshrc
   Vérifier :
   flutterfire --version
3. Initialisation Firebase dans le projet Flutter
   Se placer dans le projet :
   cd /chemin/vers/ton/projet
   Configurer Firebase :
   flutterfire configure
   Sélectionner le projet Firebase
   Choisir les plateformes (iOS, Android, Web)
   Le fichier firebase_options.dart est généré
   Initialiser Firebase dans main.dart :
   import 'package:firebase_core/firebase_core.dart';
   import 'firebase_options.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
runApp(MyApp());
} 4. Configuration iOS (CocoaPods / Xcode)
Ouvrir ios/Podfile et définir :
platform :ios, '15.0'

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['SWIFT_VERSION'] = '5.9'
end
end
end
Supprimer pods existants et lock file (pour éviter conflits) :
cd ios
rm -rf Podfile.lock Pods
Installer tous les pods à jour :
pod install --repo-update
cd ..
Nettoyer Flutter :
flutter clean
flutter pub get 5. Gestion des versions Firebase (Flutter / iOS)
Vérifier la compatibilité dans pubspec.yaml :
firebase_core: ^2.32.0
firebase_auth: ^4.16.0
Conflits typiques :
firebase_auth dépend d’une version minimale de firebase_core → mettre à jour les deux.
Pour les pods iOS, parfois pod update Firebase/Auth est nécessaire. 6. Compilation et exécution
flutter run
Si Xcode demande pour Runner.xcworkspace : choisir “Use version on disk” pour utiliser la configuration CocoaPods.
Si erreurs Swift (AccessLevelOnImport ou sending) : mettre à jour Swift dans Xcode à 5.8 ou 5.9. 7. Conseils pratiques
Toujours fermer Xcode avant flutter run ou pod install.
Garder iOS deployment target ≥ 15.0 pour Firebase 12+.
Nettoyer le projet (flutter clean) si erreur persistante.

## flutter pub add image_picker

## flutter pub add firebase_storage
