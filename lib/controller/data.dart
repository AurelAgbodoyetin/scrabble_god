import 'dart:async';
import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scrabble_god/models/word.dart';
import 'package:scrabble_god/utils/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DataController extends GetxController {
  static DataController instance = Get.find();
  late String data;
  late String rulesPath;
  late String scoresheetPath;
  late PackageInfo packageInfo;

  Future<void> load() async {
    data = await rootBundle.loadString('assets/db.txt');
    rulesPath = await getPdfPath("rules.pdf");
    scoresheetPath = await getPdfPath("score_sheets.pdf");
    packageInfo = await PackageInfo.fromPlatform();
  }

  bool checkExistence(String word) {
    return data.contains(word.toUpperCase());
  }

  List<String> findFromLetters(String text, String? start, String? end) {
    int n = '*'.allMatches(text.trim()).length;
    List<String> letters = text.toUpperCase().split('')..removeWhere((e) => e == "*");
    List<String> dataList = data.split('\n');
    List<String> words = [];
    start = start ?? "";
    start = start == "*" ? "" : start;
    end = end ?? "";
    end = end == "*" ? "" : end;
    for (String word in dataList) {
      if (word.startsWith(start.toUpperCase()) && word.endsWith(end.toUpperCase())) {
        bool r =
            letters.toSet().intersection(word.split("").toSet()).length == word.length - n;
        if (r && word.length <= text.length) {
          words.add(word);
        }
      }
    }
    return words;
  }

  List<WordScore> getBests(List<String> wordsString, [int? len]) {
    List<WordScore> words = wordsString
        .map((e) => Word(word: e))
        .map(
          (e) => WordScore.fromWord(e),
        )
        .toList();
    words.sort((a, b) => a.score.compareTo(b.score));
    words = words.reversed.toList();
    int nBest = words.length < 5 ? words.length : 5;
    List<WordScore> results = len == null ? words.sublist(0, nBest) : words;
    return results;
  }

  List<WordGroup> getWordGroups(List<String> words) {
    List<WordGroup> groups = [];
    List<int> lengths = words.map((e) => e.length).toSet().toList()..sort();
    lengths = lengths.reversed.toList();
    for (int i in lengths) {
      groups.add(WordGroup.fromResults(i, words));
    }
    return groups;
  }

  Future<String> getPdfPath(String path) async {
    Completer<File> completer = Completer();
    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$path");
      var data = await rootBundle.load("assets/$path");
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      logger.e(e);
      throw Exception('Error parsing asset file!');
    }

    return (await completer.future).path;
  }

  Future<bool> saveInStorage(String name, String path) async {
    File file = File(path);
    String res = await FileSaver.instance.saveAs(
      name,
      file.readAsBytesSync(),
      "pdf",
      MimeType.PDF,
    );
    return res != "";
  }
}
