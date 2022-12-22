import 'package:flutter/material.dart';
import 'package:scrabble_god/controller/core/instances.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A Propos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bienvenue sur Scrabble God !",
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25.0),
              const Text(
                "L'application Scrabble God a un double but : ",
                style: TextStyle(fontSize: 15.0),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  children: const [
                    Text(
                      "1. Vous aider à vous mettre tous d'accord 🤝 lors de vos longues journées de "
                      "scrabble intensives où tout le monde pense avoir la bonne orthographe pour "
                      "un mot donné. Vous n'aurez qu'à rentrer votre mot dans dans la barre "
                      "de recherche de l'onglet 'Vérifiez mot' et regarder le résultat. Scrabble "
                      "God utilise le Dictionnaire du Scrabble Officiel En Français ODS 8 du "
                      "11 juillet 2020. D'autres dictionnaires seront progressivement ajoutés.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "2. Vous suggérer des mots valides au Scrabble 😈. Entrez entre 2 et 12 lettres "
                      "et Scrabble God vous affichera tous les cpups possible avec les lettres"
                      " entrées. Vous n'aurez qu'à rentrer votre mot dans dans la barre "
                      "de recherche de l'onglet 'Composer mot' et regarder le résultat. Vous"
                      " Vous pouvez imposer un début et une fin à vos mots en "
                      "remplissant les champs 'Lettre initiale' et 'Lettre finale'. Ces deux "
                      "derniers champs ne sont pas requis pour une recherche.\nVous pouvez insérer des jokers avec "
                      "le symbole *",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Scrabble God intègre également les règles du Scrabble et une feuille de score"
                "que vous pouvez enregister sur votre téléphone et imprimer au besoin 😉.",
                style: TextStyle(fontSize: 15.0),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Bon Scrabble, et bonne triche 😁!",
                style: TextStyle(fontSize: 15.0),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Version ${dataController.packageInfo.version}",
                      style: const TextStyle(),
                    ),
                    const Text(
                      "© 2022 TAuDev",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
