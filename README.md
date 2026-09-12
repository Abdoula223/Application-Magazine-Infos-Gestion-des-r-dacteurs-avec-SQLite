# magazine_redacteurs

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Cours Développement Mobile
Niveau intermédiaire • Atelier – Activité n°5
Gestion des données locales avec SqfLite
Activité guidée – Gestion des rédacteurs
Durée : 05 heures | Modalité : individuel | Remise : fichiers .Zip des différents projets + lien GitHub
Rubrique Contenu
Objectif principal Créer une application Flutter qui gère des rédacteurs à l’aide d’une base de
données locale SQLite via sqflite.
Compétences visées Modélisation, CRUD, widgets Flutter, stockage local, boîtes de dialogue,
ListView.builder.
Modalité Activité individuelle guidée
Durée indicative 05 heures
Livrable attendu Projet Flutter compressé (.zip) contenant le code source complet et fonctionnel /
lien GitHub
1. Présentation générale de l’activité
Dans cette activité, vous allez développer une application Flutter permettant de gérer les rédacteurs du magazine
« Magazine Infos ». L’idée est de construire une petite application de gestion locale de données : l’utilisateur doit
pouvoir ajouter un rédacteur, afficher la liste des rédacteurs déjà enregistrés, modifier leurs informations et les
supprimer.
Le stockage ne se fait pas en ligne : les données sont enregistrées directement dans le téléphone ou dans
l’émulateur grâce à une base SQLite. Cette activité constitue une première mise en pratique de la gestion des
données locales dans Flutter, en s’appuyant sur le package sqflite.
Ce que vous allez apprendre
Créer un modèle de données en Dart.
Initialiser une base SQLite dans une application Flutter.
Effectuer les opérations CRUD : Create, Read, Update, Delete.
Afficher dynamiquement des données dans une interface Flutter.
Utiliser des champs de saisie, des listes et des boîtes de dialogue pour interagir avec les données.
Charger automatiquement les données existantes au démarrage de l’application.
Remarque pédagogique
Le document de départ présente directement une solution assez proche du corrigé. Ici, l’activité a été
transformée en une version guidée pour les apprenants : la démarche est détaillée, mais le code complet n’est
pas donné.
Les indications proposées doivent aider l’étudiant à structurer son travail sans supprimer l’effort de réflexion et
de programmation.
2. Pré-requis
• Avoir Flutter installé et correctement configuré.
• Savoir créer un projet Flutter et lancer une application sur un émulateur ou un appareil Android.
• Connaître les widgets de base : MaterialApp, Scaffold, TextField, ElevatedButton, ListView.builder, AlertDialog.
• Avoir déjà manipulé des classes Dart simples et des listes.
3. Contexte de l’application
L’éditeur en chef du magazine souhaite disposer d’un outil simple pour gérer ses rédacteurs. Chaque rédacteur
possède un nom, un prénom et une adresse e-mail. L’application doit permettre :
• d’ajouter un nouveau rédacteur ;
• d’afficher tous les rédacteurs enregistrés ;
• de modifier les informations d’un rédacteur ;
• de supprimer un rédacteur après confirmation.
Donnée Type attendu Rôle
id int Identifiant unique, clé primaire auto-incrémentée
nom String Nom du rédacteur
prenom String Prénom du rédacteur
email String Adresse e-mail du rédacteur
4. Organisation conseillée du projet
lib/
main.dart
modele/
redacteur.dart
services/
database_manager.dart
views/
redacteur_interface.dart
Conseil
Vous pouvez choisir une autre organisation de dossiers, mais il est recommandé de séparer au minimum le
modèle et la gestion de la base de données.
Une structure claire facilite la lecture du code et le débogage.
5. Partie 1 – Créer le modèle Redacteur
La première étape consiste à modéliser les données. Vous devez créer une classe Dart nommée Redacteur. Cette
classe représente un rédacteur de l’application.
1. Créer un fichier redacteur.dart dans un dossier modele sous lib.
2. Définir les attributs : id, nom, prenom et email.
3. Prévoir deux constructeurs : un constructeur avec tous les attributs et un constructeur sans id.
4. Créer une méthode toMap() pour transformer un objet Redacteur en Map<String, dynamic>.
5. Ajouter, si vous le souhaitez, une méthode fromMap() ou fromJson() pour reconstruire un objet à partir d’une
ligne de la base.
Indications sur les éléments de réponse
id doit être nullable ou optionnel dans le constructeur sans id, car la base de données générera
automatiquement cette valeur lors de l’insertion.
toMap() est indispensable pour insérer ou mettre à jour un objet dans la base SQLite.
Le Map retourné par toMap() doit contenir les noms de colonnes utilisés dans la table redacteurs.
Une méthode fromMap() est très utile lorsque vous récupérez une liste de Map depuis la base et que vous
souhaitez obtenir une liste d’objets Redacteur.
6. Partie 2 – Préparer la base de données locale
La deuxième étape consiste à créer une classe chargée de gérer la base de données locale. Dans cette activité,
vous utiliserez le package sqflite.
6. Ajouter les dépendances nécessaires dans pubspec.yaml.
7. Créer une classe DatabaseManager dans un dossier services.
8. Prévoir une méthode d’initialisation de la base de données.
9. Créer la table redacteurs avec les colonnes id, nom, prenom et email.
10. Ajouter les méthodes CRUD : getAllRedacteurs, insertRedacteur, updateRedacteur, deleteRedacteur.
dependencies:
flutter:
sdk: flutter
sqflite: ^2.x.x
path: ^1.x.x
Indications sur les éléments de réponse
La base de données peut être ouverte avec openDatabase(...).
Le nom de la base peut être, par exemple, redacteurs.db.
La création de la table se fait généralement dans la fonction onCreate de openDatabase.
La table redacteurs doit contenir id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, prenom TEXT, email
TEXT.
getAllRedacteurs doit retourner une liste de rédacteurs ; pour cela, il faut lire les lignes puis convertir chaque
Map en objet Redacteur.
insertRedacteur insère un nouvel objet dans la table.
updateRedacteur met à jour la ligne correspondant à l’id.
deleteRedacteur supprime la ligne correspondant à l’id.
Bon réflexe
Commencez par vérifier que la base se crée correctement avant de développer l’interface.
Si une erreur survient, affichez-la dans la console avec print() pour faciliter le débogage.
7. Partie 3 – Configurer le point d’entrée de l’application
Votre fonction main() doit démarrer l’application Flutter et invoquer un widget principal appelé MonApplication.
11. Créer un StatelessWidget nommé MonApplication.
12. Faire retourner par ce widget un MaterialApp.
13. Utiliser un titre d’application explicite.
14. Définir comme page d’accueil le widget RedacteurInterface.
Indications sur les éléments de réponse
MonApplication joue le rôle de point d’entrée visuel de votre projet.
Le MaterialApp doit contenir au minimum un titre, un thème simple et la page home.
La page home sera la classe RedacteurInterface.
8. Partie 4 – Créer l’interface RedacteurInterface
Le widget RedacteurInterface doit être un StatefulWidget. Il représente l’écran principal de gestion des
rédacteurs.
15. Créer la classe RedacteurInterface qui étend StatefulWidget.
16. Déclarer des TextEditingController pour les champs nom, prénom et email.
17. Prévoir une liste de rédacteurs à afficher dans l’écran.
18. Créer un bouton d’ajout de rédacteur.
19. Afficher les rédacteurs dans un ListView.builder.
20. Ajouter des icônes de modification et de suppression pour chaque élément de la liste.
Organisation recommandée de l’interface
Une zone supérieure contenant les champs TextField pour nom, prénom et email.
Un bouton « Ajouter un rédacteur » avec une icône d’ajout.
