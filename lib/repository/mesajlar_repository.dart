import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mesaj.dart';

class MesajlarRepository extends ChangeNotifier{

  final List<Mesaj> mesajlar=[
    Mesaj("Merhaba", "Ali", DateTime.now()),
    Mesaj("Nasılsın", "Ali", DateTime.now()),
    Mesaj("İyiyim", "Ayşe", DateTime.now()),

  ];


}

final mesajlarProvider = ChangeNotifierProvider((ref) {
  return MesajlarRepository();
});

class YeniMesajSayisi extends StateNotifier<int>{
  YeniMesajSayisi(int state) : super(state);

  void sifirla (){
    state=0;
  }
}

final yeniMesajSayisiProvider = StateNotifierProvider<YeniMesajSayisi, int>((ref) {
  return YeniMesajSayisi(3);
});

