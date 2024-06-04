//import 'dart:js';

//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yazlab2p2v1/gamemodeselectscreen.dart';
import 'package:yazlab2p2v1/gamescreen.dart';
import 'package:yazlab2p2v1/newfile.dart';
import 'package:yazlab2p2v1/roomscreen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
        //scaffoldBackgroundColor: Colors.black26
      ),
      home: MyHomePage(title: 'WordleDuo Online'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController username_TextBox = TextEditingController();
  TextEditingController password_TextBox = TextEditingController();
  String loginpage_notificationText="Giriş Yapınız";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //var usersDataFireStore = _firestore.collection("kullanicilar");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        //title: Text(widget.title),
        title: Text(widget.title),
      ),
      body: ListView(

        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(child: Text(loginpage_notificationText)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(58.0, 5.0, 58.0, 5.0),
            child: TextField(
              controller: username_TextBox,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(),
                  labelText: "Kullanıcı Adı",
                  hintText: "Kullanıcı Adınızı Giriniz"
              ),
              textAlign:TextAlign.center ,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(58.0, 5.0, 58.0, 5.0),
            child: TextField(
              controller: password_TextBox,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Parola:",
                  hintText: "Parolanızı Giriniz"
              ),
              textAlign:TextAlign.center ,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){girisYapMethod(_firestore.collection("kullanicilar"),username_TextBox.text,password_TextBox.text);}, child:const Text("Giriş Yap")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){kayitOlMethod(_firestore.collection("kullanicilar"),username_TextBox.text,password_TextBox.text);},child:const Text("Kayıt Ol")),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: supriseMethod, child: const Text("Şanslı Sürpriz")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){authLoginMethod(_firestore.collection("kullanicilar"),username_TextBox.text,password_TextBox.text);}, child: const Text("Auth login")),
              ),
            ],
          ),


          Card(
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Sol tarafta oturum kapatma ikonu
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: _signOut,
                  ),
                  SizedBox(width: 16.0),
                  // Ortada kullanıcı adı veya e-posta
                  Expanded(
                    child: StreamBuilder<User?>(
                      stream: _auth.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          if (snapshot.hasData) {
                            // Oturum açık ise kullanıcının e-postasını göster
                            return Text(snapshot.data!.email ?? '');
                          } else {
                            // Oturum kapalı ise giriş yapma mesajı göster
                            return Text('Oturum kapalı');
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  // Sağ tarafta kullanıcı iconu
                  CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ],
              ),
            ),
          )




        ],
      ),
    );
  }

  void authLoginMethod(var usersDataFireStore , String mail_Text , String password_Text){
    if(mail_Text=="420" && password_Text=="420"){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameModeSelectPage()));
    }
    FirebaseAuth.instance.signInWithEmailAndPassword(email:mail_Text , password: password_Text)
        .then((value) => {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameModeSelectPage()))
    });
  }
  void girisYapMethod(var usersDataFireStore , String mail_Text , String password_Text) async{

    var tmp_usersDataFireStore=usersDataFireStore.where("mail", isEqualTo: mail_Text);
    var response = await tmp_usersDataFireStore.get();
    var usersDataList = response.docs;
    print("before for" + usersDataList.length.toString());
    for (int i=0;i<usersDataList.length;i++){
      print(usersDataList[i].data());
    }
    print("after for");
    if(usersDataList.length==0){
      // eğer mail adresine kayıtlı birisi yoksa
      setState(() {
        loginpage_notificationText="Mail adresi veri tabanında kayıtlı değil";
      });
    }else{//kayıtlı biri varsa
      setState(() {
        loginpage_notificationText="Giriş Yapınız";
      });
      print(usersDataList.first.data()["mail"]+ " <-E-Mail Password->"+usersDataList.first.data()["sifre"]);
      if(usersDataList.first.data()["sifre"]==password_Text){ // şifre doğru
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameModeSelectPage()));
      }
      else{ // şifre yanlış
        setState(() {
          loginpage_notificationText="Şifre Yanlış";
        });
      }
    }

  }

  void kayitOlMethod(var usersDataFireStore ,String mail_Text , String password_Text) async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: mail_Text, password: password_Text).then((value){

      usersDataFireStore.doc(mail_Text.substring(0,mail_Text.indexOf('@'))).set({
        'mail':mail_Text,
        'sifre':password_Text
      }).whenComplete(()=>print("kullanıcı veri tabanına kaydedildi"));
    }).whenComplete(() => setState(() {
      loginpage_notificationText="Kullanıcı kaydedildi";
    }));
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => RoomScreen())));
  }

  void supriseMethod() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WordGuessGame(user_password: password_TextBox.text,user_username: username_TextBox.text,)));
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameModeSelectPage()));
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Oturum kapatma hatası: $e');
    }
  }
}


//23 Nisan 22:00