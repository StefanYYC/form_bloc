# onbricolemobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Install

## Pré-requis :
- Flutter d'installer (cf tuto Slack)
- xCodes à jour
- Prévoyez 15Go en plus d'xCodes
- Android Studio d'installé avec les Plugin Dart et Flutter

Une fois le projet clone, ouvrez le dans Android Studio

Sur mac ouvrez votre terminal :
- lancez : open -a simulator
Attendez que l'iphone soit chargé puis vous pouvez lancer l'appli en appuyant sur le bouton vert en haut
d'Android Studio

Sinon en passant par le terminal vous pouvez utiliser : flutter run mais c'est un peu moins pratique pour pouvoir
relancer l'appli rapidement.

Si après ça l'appli ne veut pas se lancer ou throw une erreur : flutter doctor (toujours à la racine du projet)

## Problèmes communs :

- Commande flutter non reconnu : il faut bien l'installer à la racine du mac et utiliser cette commande
pour la définir comme variable d'environnement :  export PATH="$PATH:`pwd`/flutter/bin"
- Cela peut venir de la version du terminal (cf vidéo pour changer au besoin)

## Autre :

- Installer le plugin Bloc Code Generator dans Android Studio : ce plugin permet de créer les fichiers blocs
avec la structure par défaut, pour cela clique droit sur le dossier où on veut créer notre bloc :
New > Bloc Generator > New Bloc > nom_du_bloc
