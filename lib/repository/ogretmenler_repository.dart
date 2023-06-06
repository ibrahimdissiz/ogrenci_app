import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/services/data_services.dart';

import '../models/ogretmen.dart';

class OgretmenlerRepository extends ChangeNotifier {
  List <Ogretmen>ogretmenler = [
    Ogretmen("Mehmet", "Yüksel", 36, "erkek"),
    Ogretmen("Fatma", "Kırtaş", 40, "kadın"),
  ];
  final DataService dataService;

  OgretmenlerRepository(this.dataService);

  Future<void> indir() async {
    Ogretmen ogretmen = await dataService.ogretmenIndir();

    ogretmenler.add(ogretmen);
    notifyListeners();
  }

  Future<List<Ogretmen>> hepsiniGetir() async {
    ogretmenler = await dataService.ogretmenleriGetir();
    return ogretmenler;
  }

}

final ogretmenlerProvider = ChangeNotifierProvider((ref) {
  return OgretmenlerRepository(ref.watch(dataServiceProvider));
});

final ogretmenListesiProvider = FutureProvider((ref) {
  ref.watch(ogretmenlerProvider).hepsiniGetir();
});