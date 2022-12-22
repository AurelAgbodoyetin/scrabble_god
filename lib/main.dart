import 'package:flutter/material.dart';
import 'package:scrabble_god/constants.dart';
import 'package:scrabble_god/controller/core/init.dart';
import 'package:scrabble_god/controller/core/instances.dart';
import 'package:scrabble_god/screens/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initControllers();
  await dataController.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: kGreenColor),
        fontFamily: "Ubuntu",
        primarySwatch: Colors.green,
        indicatorColor: Colors.white,
        scaffoldBackgroundColor: kBackgroundColor,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kGreenColor),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kErrorColor),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kErrorColor),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: kTextFieldFill,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
