import 'package:flutter/material.dart';
import 'package:yazlab2p2v1/gamemodeselectscreen.dart';

class ResultScreen extends StatelessWidget {
  final bool isWinner;
  final int score;
  String guessedWord;
  ResultScreen({required this.isWinner, required this.score,required this.guessedWord});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sonuç'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              isWinner ? 'Oyunu kazandın!' : 'Oyunu kaybettin!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Puanınız: $score\n kelimeniz ${guessedWord}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameModeSelectPage()));
              },
              child: Text('Yeniden Oyna'),
            ),
          ],
        ),
      ),
    );
  }
}

//23 Nisan 22:00
