import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/bist_model.dart';

class BitsStatsProvider extends ChangeNotifier {
  List<Item> bitsStats = List<Item>();
  Future<List<Item>> getBitsStats() async {
    Bist bist = await DunyaApiManager().getBIST(true);
    if (bist != null) {
       bist.data.items.forEach((element) {
        bitsStats.add(element);
      });
    }
    return bitsStats;
  }
}
