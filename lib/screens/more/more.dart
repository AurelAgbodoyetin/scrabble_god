import 'package:flutter/material.dart';
import 'package:scrabble_god/constants.dart';
import 'package:scrabble_god/controller/core/instances.dart';
import 'package:scrabble_god/screens/about/about.dart';
import 'package:scrabble_god/screens/pdf/pdf.dart';
import 'package:scrabble_god/utils/button.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Plus")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            text: "Règles du jeu",
            bgColor: Colors.white,
            textColor: kTextColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFScreen(
                    path: dataController.rulesPath,
                    title: "Règles du jeu",
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10.0),
          CustomButton(
            text: "Fiche de score",
            bgColor: Colors.white,
            textColor: kTextColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFScreen(
                    path: dataController.scoresheetPath,
                    title: "Fiche de score",
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10.0),
          CustomButton(
            text: "Choisir le dictionnaire",
            bgColor: Colors.white,
            textColor: kTextColor,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Fonctionnalité à venir"),
                  ),
                  elevation: 2,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                ),
              );
            },
          ),
          const SizedBox(height: 10.0),
          CustomButton(
            text: "A Propos",
            bgColor: Colors.white,
            textColor: kTextColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 10.0),
          CustomButton(
            text: "Noter",
            bgColor: Colors.white,
            textColor: kTextColor,
            onTap: () {},
          ),
          const SizedBox(height: 10.0),
          CustomButton(
            text: "Partager",
            bgColor: Colors.white,
            textColor: kTextColor,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
