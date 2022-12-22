import 'package:flutter/material.dart';
import 'package:scrabble_god/constants.dart';
import 'package:scrabble_god/controller/core/instances.dart';
import 'package:scrabble_god/models/word.dart';
import 'package:scrabble_god/utils/button.dart';

class ComposeTab extends StatefulWidget {
  const ComposeTab({super.key});

  @override
  State<ComposeTab> createState() => _ComposeTabState();
}

class _ComposeTabState extends State<ComposeTab> {
  late GlobalKey<FormState> key;
  bool shouldValidate = false;
  String letters = "";
  String? start;
  String? end;
  List<Widget> results = [];
  late TextEditingController controller;
  late TextEditingController scontroller;
  late TextEditingController econtroller;

  @override
  void dispose() {
    controller.dispose();
    scontroller.dispose();
    econtroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    key = GlobalKey<FormState>();
    controller = TextEditingController();
    scontroller = TextEditingController();
    econtroller = TextEditingController();
    super.initState();
  }

  Widget bestWordsCard(List<String> words) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Card(
          elevation: 3.0,
          color: kCardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text(
                  "Les meilleurs  mots",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Wrap(
                  spacing: 7.0,
                  runSpacing: 7.0,
                  children: dataController
                      .getBests(words)
                      .map(
                        (word) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${word.word}(",
                              style: const TextStyle(fontSize: 15.0),
                            ),
                            Text(
                              "${word.score}",
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              ")",
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: key,
        autovalidateMode: shouldValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              const Text(
                "Saisissez jusqu'à 10 lettres pour chercher des mots valides. Utilisez des * comme joker (2 au maximum).",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                cursorColor: kGreenColor,
                controller: controller,
                maxLength: 12,
                decoration: InputDecoration(
                  hintText: "zevhkb*",
                  suffixIcon: Visibility(
                    visible: controller.text.isNotEmpty,
                    child: GestureDetector(
                      child: const Icon(Icons.close),
                      onTap: () {
                        setState(() {
                          letters = "";
                          controller.text = "";
                          scontroller.text = "";
                          econtroller.text = "";
                          shouldValidate = false;
                        });
                      },
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return "Entrez des lettres à chercher";
                  }
                  if (value.trim().length < 2) {
                    return "Entrez dau moins 2 lettre pour chercher";
                  } else {
                    if ('*'.allMatches(value.trim()).length > 2) {
                      return "Vous ne pouvez pas utiliser plus de 2 jokers";
                    }
                  }
                  return null;
                },
                onSaved: (value) {
                  letters = value!;
                },
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: kGreenColor,
                      controller: scontroller,
                      maxLength: 1,
                      decoration: const InputDecoration(
                        hintText: "Lettre initiale",
                        counterText: "",
                      ),
                      onSaved: (value) {
                        start = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: TextFormField(
                      cursorColor: kGreenColor,
                      controller: econtroller,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        hintText: "Lettre finale",
                        counterText: "",
                      ),
                      onSaved: (value) {
                        end = value;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              CustomButton(
                text: "Chercher",
                onTap: () {
                  setState(() {
                    shouldValidate = true;
                  });
                  if (key.currentState!.validate()) {
                    key.currentState!.save();
                    List<String> words = dataController.findFromLetters(letters, start, end);
                    List<WordGroup> groups = dataController.getWordGroups(words);
                    if (words.isNotEmpty) {
                      setState(() {
                        results = [bestWordsCard(words)];
                        results.addAll(groups.map((group) => group.getCard()).toList());
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 30.0),
              Column(
                children: results,
              )
            ],
          ),
        ),
      ),
    );
  }
}
