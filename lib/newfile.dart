import 'package:flutter/material.dart';
import 'dart:math';

class WordGuessGame extends StatefulWidget {
  @override
  String user_username="Default_Username";
  String user_password="Default_Password";
  WordGuessGame({required this.user_username,required this.user_password});
  _WordGuessGameState createState() => _WordGuessGameState();
}

class _WordGuessGameState extends State<WordGuessGame> {
  final List<String> _words = [
    "elma",
    "muz",
    "portakal",
    "üzüm",
    "çilek",
    "ananas",
    "karpuz",
    "kivi",
    "mango",
    "şeftali"
  ];

  late String _targetWord;
  late String _hint;
  late int _remainingAttempts;
  TextEditingController _guessController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    Random random = Random();
    int index = random.nextInt(_words.length);
    _targetWord = _words[index];
    _hint = "Kelimeyi tahmin etmeye hazır mısın?"+ widget.user_username+" sifre:"+widget.user_password;
    _remainingAttempts = 5;
  }

  void _checkGuess(String guess) {
    setState(() {
      if (guess.toLowerCase() == _targetWord) {
        _hint = "Tebrikler! Doğru tahmin ettiniz: $_targetWord";
      } else {
        _remainingAttempts--;
        if (_remainingAttempts > 0) {
          _hint =
          "Yanlış tahmin. Kalan deneme hakkı: $_remainingAttempts";
        } else {
          _hint = "Oyunu kaybettiniz. Doğru kelime: $_targetWord";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelime Tahmin Oyunu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _hint,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _guessController,
              decoration: InputDecoration(
                hintText: 'Tahmininizi girin',
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _checkGuess(_guessController.text);
              },
              child: Text("Tahmin Et"),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _initializeGame();
                  _guessController.clear();
                });
              },
              child: Text("Yeni Oyun"),
            ),
          ],
        ),
      ),
    );
  }
}

//23 Nisan 22:00