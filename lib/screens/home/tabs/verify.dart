import 'package:flutter/material.dart';
import 'package:scrabble_god/constants.dart';
import 'package:scrabble_god/controller/core/instances.dart';
import 'package:scrabble_god/utils/button.dart';

class VerifyTab extends StatefulWidget {
  const VerifyTab({super.key});

  @override
  State<VerifyTab> createState() => _VerifyTabState();
}

class _VerifyTabState extends State<VerifyTab> {
  late TextEditingController controller;
  String result = "";
  Color color = Colors.transparent;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          const Text(
            "Vérifier l'existence d'un mot dans le dictionnaire scrabble",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          TextField(
            controller: controller,
            cursorColor: kGreenColor,
            decoration: InputDecoration(
              hintText: "Entrer un mot à chercher",
              suffixIcon: Visibility(
                visible: controller.text.isNotEmpty,
                child: GestureDetector(
                  child: const Icon(Icons.close),
                  onTap: () {
                    setState(() {
                      controller.text = "";
                      result = "";
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          CustomButton(
            text: "Vérifier",
            onTap: () {
              if (controller.text.isNotEmpty) {
                bool exists = dataController.checkExistence(controller.text);
                setState(() {
                  result = exists
                      ? "Le mot ${controller.text} est valide"
                      : "Le mot ${controller.text} est invalide";
                  color = exists ? kSuccessColor : kErrorColor;
                });
              }
            },
          ),
          const SizedBox(height: 30.0),
          Text(
            result,
            style: TextStyle(color: color),
          )
        ],
      ),
    );
  }
}
