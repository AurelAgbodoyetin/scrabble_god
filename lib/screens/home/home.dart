import 'package:flutter/material.dart';
import 'package:scrabble_god/constants.dart';
import 'package:scrabble_god/screens/home/tabs/compose.dart';
import 'package:scrabble_god/screens/home/tabs/verify.dart';
import 'package:scrabble_god/screens/more/more.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kGreenColor,
          title: const Text("Scrabble God"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.check_outlined), text: "Vérifier mot"),
              Tab(icon: Icon(Icons.draw_outlined), text: "Composer mot"),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MoreScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            VerifyTab(),
            ComposeTab(),
          ],
        ),
      ),
    );
  }
}
