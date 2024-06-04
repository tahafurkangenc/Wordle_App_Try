import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yazlab2p2v1/gamemodeselectscreen.dart';
import 'package:yazlab2p2v1/resultscreen.dart';

class BoxProperties{
  late String Box_Text = "-";
  late Color Box_Color = Colors.deepOrange;

  BoxProperties({required this.Box_Text,required this.Box_Color});
}

class GameScreen extends StatefulWidget {
  String user_username="Def";
  int boxCount=6; // inner [][i]
  int rowCount=6; // outer [o][]
  int guessCounter=0;
  String Guess_the_word="alikoç";
  late List<List<BoxProperties>> BoxProperties_matris;
  //matrisin default tanımlaması burada verildi
  GameScreen({super.key,required this.user_username,required this.Guess_the_word , required this.boxCount}){

    BoxProperties_matris = List.generate(rowCount,
          (rowIndex) => List.generate(
        boxCount,
            (columnIndex) => BoxProperties(Box_Text: "", Box_Color:Colors.indigo),
      ),
    );
    FirebaseAuth user_Auth = FirebaseAuth.instance;
    if(user_Auth.currentUser != null){
      print("current user : "+ user_Auth.currentUser!.uid);
    }

    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < boxCount; j++) {
        print('(${BoxProperties_matris[i][j].Box_Text}, ${BoxProperties_matris[i][j].Box_Color})');
      }
    }
  }

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String input_dialogue_string = "Hamlenizi Yazınız";
  TextEditingController word_guess_TextBox = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text(
            'WordleDuo - Game',
            style: TextStyle(
              color: Colors.white,
              shadows:  [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.grey,
                  offset: Offset(5.0, 5.0),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildMatrixBoxes(widget.boxCount, widget.rowCount,widget.BoxProperties_matris)
            ),
            Center(
              child: Text(
                input_dialogue_string,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(58.0, 5.0, 58.0, 5.0),
              child: TextField(
                controller: word_guess_TextBox,
                decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Kelime Girişi",
                    hintText: "Lütfen "+widget.boxCount.toString() +" harfli kelimenizi giriniz"
                ),
                textAlign:TextAlign.center ,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
              child: ElevatedButton(onPressed: denemeDegistir, child:const Text("Hamle Yap")),
            ),
          ],
        ),
      );
  }

  Widget _buildBox(int index,BoxProperties boxProperties) {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.grey, // Set the background color to black
        border: Border.all(
          color: boxProperties.Box_Color, // Set the border color
          width: 4.0, // Adjust the border width as needed
        ),
        borderRadius: BorderRadius.circular(10.0), // Add rounded corners
      ),
      child: Center(
        child: Text(
          boxProperties.Box_Text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  List<Widget> buildMatrixBoxes(int innerCount, int outerCount,List<List<BoxProperties>> boxpropertiesMatris) {
    return List.generate(outerCount, (outerIndex) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(innerCount, (innerIndex) {
            return _buildBox(outerIndex * innerCount + innerIndex,boxpropertiesMatris[outerIndex][innerIndex]);
          }),
        ),
      );
    });
  }

  void denemeDegistir() {
    setState(() {

      if(word_guess_TextBox.text.length<widget.boxCount){// girilen kelime kutu sayısından küçükse çık
        input_dialogue_string = "Lütfen "+widget.boxCount.toString()+" harfli bir değer giriniz";
        return;
      }

      if(widget.guessCounter< widget.rowCount){ // eğer ekran dolmadıysa

        if(word_guess_TextBox.text.length>widget.boxCount){
          input_dialogue_string="ilk "+widget.boxCount.toString()+" harf alındı";
        }
        else{
          input_dialogue_string = "Hamlenizi Yazınız";
        }
        for(int i=0;i<widget.boxCount;i++){
          widget.BoxProperties_matris[widget.guessCounter][i].Box_Text=word_guess_TextBox.text.toString()[i];
          if(widget.Guess_the_word.contains(word_guess_TextBox.text.toString()[i])){ // eğer harfi içeriyorsa
            if(widget.Guess_the_word[i] == word_guess_TextBox.text[i]){ // aynı harf denk geliyor
              widget.BoxProperties_matris[widget.guessCounter][i].Box_Color=const Color.fromRGBO(0, 247, 32, 1,);
            }
            else{
              widget.BoxProperties_matris[widget.guessCounter][i].Box_Color=Colors.amberAccent;
            }
          }
        }

        if(word_guess_TextBox.text.toUpperCase() == widget.Guess_the_word.toUpperCase()){
          input_dialogue_string="Kelimeyi bildin";

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResultScreen(isWinner: true, score: 10*widget.boxCount,guessedWord: widget.Guess_the_word)));

          /*showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Kelimeyi Bildin'),
                content: Text('Puanın : '+(10*widget.boxCount).toString()),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      // Popup mesajı kapat
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameModeSelectPage()));
                    },
                    child: Text('Kapat'),
                  ),
                ],
              );
            },
          );*/
        }
        if(widget.guessCounter == widget.rowCount-1){
          input_dialogue_string = "Hamle hakkınız kalmadı.";
        }
        widget.guessCounter++; // işlem sonunda tahmin sayısını 1 arttırdık
      }
      else{
        int tmp_puan=0;
        for(int i=0;i<widget.BoxProperties_matris[widget.rowCount-1].length;i++){
          if(widget.BoxProperties_matris[widget.rowCount-1][i].Box_Text.toLowerCase()==widget.Guess_the_word[i].toLowerCase()){
            tmp_puan=tmp_puan+10;
          }else if (widget.Guess_the_word.toLowerCase().contains(widget.BoxProperties_matris[widget.rowCount-1][i].Box_Text.toLowerCase())){
            tmp_puan=tmp_puan+5;
          }
        }
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResultScreen(isWinner: false, score: tmp_puan,guessedWord: widget.Guess_the_word)));
        /*showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hamle hakkınız kalmadı'),
              content: Text('Puanın : '+tmp_puan.toString() + "\nDoğru Kelime : "+widget.Guess_the_word),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Popup mesajı kapat
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameModeSelectPage()));
                  },
                  child: Text('Kapat'),
                ),
              ],
            );
          },
        );*/
      }
    });
  }
}

// 23 nisan 22:00