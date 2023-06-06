import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ogrenci.dart';

class OgrencilerRepository extends ChangeNotifier {

  final ogrenciler = [
    Ogrenci("Ali", "Deniz", 12, "erkek"),
    Ogrenci("Ayşe", "Yılmaz", 14, "kadın"),


  ];

  final Set<Ogrenci> sevdiklerim= {

  };

  void sev(Ogrenci ogrenci, bool seviyorMuyum) {
    if (seviyorMuyum){
      sevdiklerim.add(ogrenci);
    }else {
      sevdiklerim.remove(ogrenci);
    }
    notifyListeners();
  }

  bool seviyorMuyum(Ogrenci ogrenci){
    return sevdiklerim.contains(ogrenci);
  }
}

final ogrencilerProvider = ChangeNotifierProvider((ref) {
  return OgrencilerRepository();
});

