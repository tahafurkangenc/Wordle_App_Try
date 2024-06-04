import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yazlab2p2v1/gamescreen.dart';

class OnlineWordSection extends StatelessWidget {
  late int word_range;
  late String user_number_String; // 'user1' veya 'user2' olarak tutulur
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late var room_documents_Firebase;//=_firestore.collection("odalar").doc("oda1");
  TextEditingController player_to_player_TextController =TextEditingController();
  OnlineWordSection({required this.user_number_String , required this.word_range,required this.room_documents_Firebase});

  @override
  Widget build(BuildContext context) {
    //var tmp_room_ref= _firestore.collection("odalar").doc();
    late String other_user_number_string; //diğer kullanıcıyı kontrol eder
    if(user_number_String=="user1"){
      other_user_number_string="user2";
    }
    if(user_number_String=="user2"){
      other_user_number_string="user1";
    }

    return StreamBuilder<DocumentSnapshot>(
        stream: room_documents_Firebase.snapshots(),
        builder: (context, AsyncSnapshot asyncSnapshot) {

          if(asyncSnapshot.hasError){
            return const Center(
              child:
              Text(
                  'ERROR-asyncSnapshot.hasError-ERROR'
              ),);
          }
          else{
            if(asyncSnapshot.hasData){ // asyncSnapshot içinde data var ---> buradan işlemleri gerçekleştireceğiz

              if(asyncSnapshot.data.data()[user_number_String+"_mail"].toString().contains('@')){
                if(asyncSnapshot.data.data()["${user_number_String}_to_${other_user_number_string}_word"].toString().length==word_range){
                  if(asyncSnapshot.data.data()[other_user_number_string+"_mail"].toString().contains('@')){
                    if(asyncSnapshot.data.data()["${other_user_number_string}_to_${user_number_String}_word"].toString().length==word_range){
                      Future.delayed(Duration.zero, () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameScreen(
                            user_username: asyncSnapshot.data.data()[user_number_String+"_mail"].toString(),
                            Guess_the_word: asyncSnapshot.data.data()["${other_user_number_string}_to_${user_number_String}_word"].toString(),
                            boxCount:word_range
                        )
                        ));
                      });
                    }else{
                      print("${other_user_number_string} isimli kullanıcının kelimesi uygun değil");
                    }
                  }else{
                    print("${other_user_number_string} isimli kullanıcının maili onaylı değil");
                  }
                }else{
                  print("${user_number_String} isimli kullanıcının kelimesi uygun değil");
                }
              }else{
                print("${user_number_String} isimli kullanıcının maili onaylı değil");
              }

            }
            else{
              return const Center(
                child:
                CircularProgressIndicator(),
              );
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Word Section'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Bir Metin Girişi Yapın',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: player_to_player_TextController,
                      decoration: InputDecoration(
                        hintText: 'Metin giriniz',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async{
                        await room_documents_Firebase.update({"${user_number_String}_to_${other_user_number_string}_word":player_to_player_TextController.text});
                      },
                      child: Text('Gönder'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

//23 Nisan 22:00