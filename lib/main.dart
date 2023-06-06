import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/pages/ogrenciler_sayfası.dart';
import 'package:ogrenci_app/pages/ogretmenler_sayfası.dart';
import 'package:ogrenci_app/pages/mesajlar_sayfası.dart';
import 'package:ogrenci_app/repository/mesajlar_repository.dart';
import 'package:ogrenci_app/repository/ogrenciler_repository.dart';
import 'package:ogrenci_app/repository/ogretmenler_repository.dart';

void main() {
  runApp(const ProviderScope(child: OgrenciApp()));
}

class OgrenciApp extends StatelessWidget {
  const OgrenciApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ogrenci Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isFirebaseInitialized=true;

  @override
  void initState() {

    super.initState();
    initializeFirebase();
  }
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInitialized = true;
    });
      anaSayfayaGit();
  }

  void anaSayfayaGit() {
     Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder:
            (context) => const AnaSayfa(title: ' Ana Sayfa'),
    ),
        );
  }
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(
          child: CircularProgressIndicator()
       ),
    );
  }


}


class AnaSayfa extends ConsumerWidget {
  const AnaSayfa({Key?key, required this.title}) : super (key: key);


  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ogrencilerRepository=ref.watch(ogrencilerProvider);
    final ogretmenlerRepository=ref.watch(ogretmenlerProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  _mesajlaraGit(context);

                },
                child: Text('${ref.watch(yeniMesajSayisiProvider)} Yeni Mesaj')),
            TextButton(
                onPressed: () {
                  _ogrencilereGit(context);
                },
                child: Text('${ogrencilerRepository.ogrenciler.length} Öğrenci')),
            TextButton(
                onPressed: () {
                  _ogretmenlereGit(context);
                },
                child: Text('${ogretmenlerRepository.ogretmenler.length} Öğretmen'))
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Öğrenci Adı '),
            ),
            ListTile(
              title: const Text('Öğrenciler'),
              onTap: (){
                _ogrencilereGit(context);
              },
            ),
            ListTile(
              title: const Text('Öğretmenler'),
              onTap: (){
                _ogretmenlereGit(context);
              },
            ),
            ListTile(
              title: const Text('Mesajlar'),
              onTap: (){
                _mesajlaraGit(context);
              },
            )
          ],

        ),
      ),
    );
  }

  Future<void> _mesajlaraGit(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return  const MesajlarSayfasi();
    },));
    
  }

  void _ogrencilereGit(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return  const OgrencilerSayfasi();

    }));
  }

  void _ogretmenlereGit(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return  const OgretmenlerSayfasi();
    }));
  }

}
