// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:scrabble_god/constants.dart';
import 'package:scrabble_god/controller/core/instances.dart';

class Letter {
  final String letter;
  final int score;
  final int qtt;

  static List<Letter> letters = [
    Letter(letter: "A", score: 1, qtt: 9),
    Letter(letter: "B", score: 3, qtt: 2),
    Letter(letter: "C", score: 3, qtt: 2),
    Letter(letter: "D", score: 2, qtt: 3),
    Letter(letter: "E", score: 1, qtt: 15),
    Letter(letter: "F", score: 4, qtt: 2),
    Letter(letter: "G", score: 2, qtt: 2),
    Letter(letter: "H", score: 4, qtt: 2),
    Letter(letter: "I", score: 1, qtt: 8),
    Letter(letter: "J", score: 8, qtt: 1),
    Letter(letter: "K", score: 10, qtt: 1),
    Letter(letter: "L", score: 1, qtt: 5),
    Letter(letter: "M", score: 2, qtt: 3),
    Letter(letter: "N", score: 1, qtt: 6),
    Letter(letter: "O", score: 1, qtt: 6),
    Letter(letter: "P", score: 3, qtt: 2),
    Letter(letter: "Q", score: 8, qtt: 1),
    Letter(letter: "R", score: 1, qtt: 6),
    Letter(letter: "S", score: 1, qtt: 6),
    Letter(letter: "T", score: 1, qtt: 6),
    Letter(letter: "U", score: 1, qtt: 6),
    Letter(letter: "V", score: 4, qtt: 2),
    Letter(letter: "W", score: 10, qtt: 1),
    Letter(letter: "X", score: 10, qtt: 1),
    Letter(letter: "Y", score: 10, qtt: 1),
    Letter(letter: "Z", score: 10, qtt: 1),
    Letter(letter: "*", score: 0, qtt: 2),
  ];

  Letter({
    required this.letter,
    required this.score,
    required this.qtt,
  });
}

class Word {
  final String word;
  Word({
    required this.word,
  });

  int score() {
    int s = 0;
    for (String l in word.toUpperCase().split('')) {
      s = s + Letter.letters.firstWhere((e) => e.letter == l).score;
    }
    return s;
  }

  @override
  String toString() => 'Word($word)';
}

class WordScore {
  final String word;
  final int score;
  WordScore({
    required this.word,
    required this.score,
  });

  factory WordScore.fromWord(Word word) {
    return WordScore(word: word.word, score: word.score());
  }

  @override
  String toString() => 'WordScore(word: $word, score: $score)';
}

class WordGroup {
  final List<Word> words;
  final int length;
  WordGroup({
    required this.words,
    required this.length,
  });

  factory WordGroup.fromResults(int len, List<String> words) {
    return WordGroup(
      words: words.where((w) => w.length == len).map((e) => Word(word: e)).toList(),
      length: len,
    );
  }

  Widget getCard() {
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
                Text(
                  "Mots à $length lettres",
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Wrap(
                  spacing: 7.0,
                  runSpacing: 7.0,
                  children: dataController
                      .getBests(words.map((e) => e.word).toList(), 1)
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
  String toString() => 'WordGroup(words: $words, length: $length)';
}
