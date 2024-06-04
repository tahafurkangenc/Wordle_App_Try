import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yazlab2p2v1/onlinewordsection.dart';

class RoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oda Panelleri'),
      ),
      body: RoomPanelList(),
    );
  }
}

class RoomPanelList extends StatelessWidget {
  final List<String> rooms = [
    'Oda 0',
    'Oda 1',
    'Oda 2',
    'Oda 3',
  ];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("odalar").snapshots(),
        builder: (context, AsyncSnapshot asyncSnapshot) {
          if(asyncSnapshot.hasError){
            return Center(child: Text("ERROR"),);
          }else if(asyncSnapshot.hasData){
            List<DocumentSnapshot> listofDocumentSnapOfRooms=asyncSnapshot.data!.docs;
            return ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (BuildContext context, int index) {
                if(listofDocumentSnapOfRooms[index].data() != null) {

                  //return RoomPanel(roomName: rooms[index] + " userCount:" +
                  //  listofDocumentSnapOfRooms[index].data()!['user_count'].toString());
                  return RoomPanel(
                      roomName: "${rooms[index]} userCount: ${listofDocumentSnapOfRooms[index]['user_count']}/2 wordRange: ${listofDocumentSnapOfRooms[index]['word_range']}",
                      roomindex: index);
                }
              },
            );
          }
          else{
            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }
        }
    );
  }
}

class RoomPanel extends StatelessWidget {
  String roomName;
  int roomindex;
  RoomPanel({required this.roomName, required this.roomindex});
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth user_Auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey, // Panel rengi burada belirleniyor
      margin: EdgeInsets.all(23.0),
      child: ListTile(
        title: Text(
          roomName,
          style: TextStyle(color: Colors.white), // Yazı rengi beyaz yapılıyor
        ),
        onTap: () async{
          var response = await _firestore.collection("odalar").get();
          var room_firebase_list=response.docs;
          var room_info_database = await FirebaseFirestore.instance.collection('odalar').doc("oda${roomindex}"); // odanın veri tabanını tutar
          if(room_firebase_list[roomindex].data()['user_count']==0){
            try {
              room_info_database.update({
                'user_count': 1,
                'user1_mail':user_Auth.currentUser?.email
              });
              print('Oda kullanıcı sayısı güncellendi.');
            } catch (e) {
              print('Hata oluştu: $e');
            }
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OnlineWordSection(user_number_String: 'user1',room_documents_Firebase: room_info_database,word_range: room_firebase_list[roomindex].data()['word_range'])));
          }
          if(room_firebase_list[roomindex].data()['user_count']==1){

            try {
              await FirebaseFirestore.instance.collection('odalar').doc("oda${roomindex}").update({
                'user_count': 2,
                'user2_mail':user_Auth.currentUser?.email
              });
              print('Oda kullanıcı sayısı güncellendi.');
            } catch (e) {
              print('Hata oluştu: $e');
            }
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OnlineWordSection(user_number_String: 'user2',room_documents_Firebase: room_info_database,word_range: room_firebase_list[roomindex].data()['word_range'])));
          }
          if(room_firebase_list[roomindex].data()['user_count']==2){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$roomName --> Oda Dolu!'),
              ),
            );
          }

        },
      ),
    );
  }
}

//23 Nisan 22:00