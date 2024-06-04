import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yazlab2p2v1/gamescreen.dart';
import 'package:yazlab2p2v1/roomscreen.dart';

class KelimeListeleri {
  static List<String> dortHarfliKelimeler = [
    'Abla', 'Acil', 'Ağız', 'Anne', 'Ayva', 'Baba', 'Bina', 'Bant', 'Cuma', 'Cips',
    'Çapa', 'Çini', 'Dere', 'Ders', 'Deve', 'Ecel', 'Elif', 'Ense', 'Eşek', 'Fare',
    'Fark', 'Fren', 'Grev', 'Gıda', 'Gram', 'Hacı', 'Hale', 'Huri', 'İnek', 'İzin',
    'İsim', 'Işık', 'Jant', 'Jöle', 'Kabe', 'Kafa', 'Klor', 'Kira', 'Kötü', 'Laik',
    'Lüks', 'Link', 'Maaş', 'Mama', 'Mola', 'Müze', 'Nane', 'Neşe', 'Oyun', 'Ordu',
    'Onay', 'Oruç', 'Örtü', 'Özür', 'Özet', 'Paça', 'Park', 'Para', 'Roka', 'Rota',
    'Rüku', 'Saat', 'Semt', 'Spor', 'Şarj', 'Turp', 'Tava', 'Uzay', 'Uzun', 'Ürün',
    'Vinç', 'Yapı', 'Yöre', 'Zarf'
  ];

  static List<String> besHarfliKelimeler = [
    'Afaki', 'Açlık', 'Abiye', 'Abbas', 'Balon', 'Bahri', 'Bahçe', 'Cacık', 'Camcı', 'Cıbıl',
    'Cümle', 'Çöpçü', 'Çürük', 'Çinli', 'Çinko', 'Çözüm', 'Dilim', 'Daimi', 'Dilek', 'Dışkı',
    'Ezber', 'Evlat', 'Enfes', 'Fosil', 'Felek', 'Gayet', 'Giyim', 'Gazoz', 'Hamak', 'Hoşaf',
    'Hamsi', 'İnmek', 'İnkar', 'İbraz', 'Irkçı', 'Ilgaz', 'Jokey', 'Jarse', 'Kredi', 'Kalın',
    'Kablo', 'Lüzum', 'Lotus', 'Leğen', 'Mevla', 'Masal', 'Melez', 'Nişan', 'Nalan', 'Ninni',
    'Oğlak', 'Övmek', 'Ördek', 'Pilot', 'Posta', 'Rampa', 'Roman', 'Sakız', 'Savcı', 'Şifre',
    'Tekne', 'Uzman', 'Üzgün', 'Vakıf', 'Yalın', 'Zehir','Ucube'
  ];

  static List<String> altiHarfliKelimeler = [
    'Abdest', 'Ahiret', 'Akıllı', 'Balayı', 'Bakiye', 'Bitter', 'Cüzdan', 'Cömert', 'Çeyrek', 'Çember',
    'Çıplak', 'Dakika', 'Dalgıç', 'Defolu', 'Dikkat', 'Eczacı', 'Emanet', 'Erişte', 'Filtre', 'Fincan',
    'Finans', 'Gofret', 'Gözlük', 'Güncel', 'Haksız', 'Hamile', 'Hangar', 'İçecek', 'İnşaat', 'İyilik',
    'Ilıman', 'Jeolog', 'Kafein', 'Kaktüs', 'Kamyon', 'Kirpik', 'Kraker', 'Laktoz', 'Lateks', 'Meclis',
    'Merkez', 'Migren', 'Nefret', 'Numune', 'Oklava', 'Otogar', 'Özveri', 'Önemli', 'Piyasa', 'Peynir',
    'Protez', 'Parfüm', 'Rustik', 'Rüzgar', 'Saniye', 'Sağdıç', 'Sağlam', 'Şamdan', 'Tablet', 'Toptan',
    'Tropik', 'Tabiat', 'Termal', 'Ulaşım', 'Ülkücü', 'Üretim', 'Vadeli', 'Vizyon', 'Yaprak', 'Yazlık',
    'Yüklük', 'Zahmet', 'Zincir', 'Zeybek'
  ];

  static List<String> yediHarfliKelimeler = [
    'Alerjik', 'Alkolik', 'Arınmak', 'Boşanma', 'Bilmece', 'Börülce', 'Ciğerci', 'Camekan', 'Cezaevi', 'Çelişki',
    'Çeşnici', 'Demleme', 'Denizci', 'Diriliş', 'Eğitmen', 'Egzotik', 'Emlakçı', 'Felaket', 'Fabrika', 'Genelge',
    'Gırtlak', 'Haziran', 'Hipotez', 'İtfaiye', 'İntikam', 'Ispanak', 'Izdırap', 'Israrcı', 'Japonca', 'Jelatin',
    'Kadrolu', 'Kafadar', 'Kanarya', 'Kariyer', 'Kamuoyu', 'Kamelya', 'Lanetli', 'Lavanta', 'Medikal', 'Medrese',
    'Meziyet', 'Nakliye', 'Nikahlı', 'Nöbetçi', 'Obezite', 'Okyanus', 'Oyuncak', 'Özvatan', 'Öncülük', 'Palyaço',
    'Palmiye', 'Payetli', 'Refleks', 'Rivayet', 'Rütbeli', 'Sanatçı', 'Santral', 'Selamet', 'Senaryo', 'Şehirli',
    'Şövalye', 'Şüpheli', 'Taahhüt', 'Tabanca', 'Telefon', 'Uyanmak', 'Uzunluk', 'Uslanma', 'Üçkağıt', 'Ücretli',
    'Üroloji', 'Vasiyet', 'Vanilya', 'Veraset', 'Yağışlı', 'Yatırım', 'Yapımcı', 'Yemekli', 'Zehirli', 'Ziyafet',
    'Zooloji','Otomata'
  ];
}

class GameModeSelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oyun Modu Seçimi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                FirebaseAuth user_Auth = FirebaseAuth.instance;
                if(user_Auth.currentUser!=null){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameScreen(
                      user_username: user_Auth.currentUser!.email.toString(),
                      Guess_the_word: KelimeListeleri.dortHarfliKelimeler[Random().nextInt(KelimeListeleri.dortHarfliKelimeler.length)],
                      boxCount:4
                  )
                  ));
                }
              },
              child: Text('Offline - 4 Harfli'),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth user_Auth = FirebaseAuth.instance;
                if(user_Auth.currentUser!=null){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameScreen(
                      user_username: user_Auth.currentUser!.email.toString(),
                      Guess_the_word: KelimeListeleri.besHarfliKelimeler[Random().nextInt(KelimeListeleri.besHarfliKelimeler.length)],
                      boxCount:5
                  )
                  ));
                }
              },
              child: Text('Offline - 5 Harfli'),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth user_Auth = FirebaseAuth.instance;
                if(user_Auth.currentUser!=null){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameScreen(
                      user_username: user_Auth.currentUser!.email.toString(),
                      Guess_the_word: KelimeListeleri.altiHarfliKelimeler[Random().nextInt(KelimeListeleri.altiHarfliKelimeler.length)],
                      boxCount:6
                  )
                  ));
                }
              },
              child: Text('Offline - 6 Harfli'),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth user_Auth = FirebaseAuth.instance;
                if(user_Auth.currentUser!=null){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameScreen(
                      user_username: user_Auth.currentUser!.email.toString(),
                      Guess_the_word: KelimeListeleri.yediHarfliKelimeler[Random().nextInt(KelimeListeleri.yediHarfliKelimeler.length)],
                      boxCount:7
                  )
                  ));
                }
              },
              child: Text('Offline - 7 Harfli'),
            ),

            SizedBox(height: 20), // Butonlar arasında bir boşluk bırakır

            ElevatedButton(
              onPressed: () {

                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RoomScreen()));
              },
              child: Text('Online'),
            ),
          ],
        ),
      ),
    );
  }
}
//23 Nisan 22:00