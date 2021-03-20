import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class SportProvider extends ChangeNotifier {
  List<Item> aa = List<Item>();
  int skip = 0;
  String id = '5fa6ea2f1913fb1ae0497abf';
  List<Item> get getspor => aa;
  Future<List<Item>> getSportNews() async {
    aa.clear();
    Posts a =
        await DunyaApiManager().getPostsFromCatagoryIDWithPagination(id, 0, 5);
    aa = a.data.items;
    return aa;
  }

  Future<List<Item>> getMoreSportNews() async {
    skip = skip + 5;
    try {
      Posts a = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(id, skip, 5);
      if (a != null) {
        aa.addAll(a.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    print('b');
    print(aa.length);
    return aa;
  }

  Future<List<Item>> refreshSportNews() async {
    skip = 0;
    try {
      Posts a = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(id, 0, 5);

      if (a != null) {
        aa.clear();
        aa = a.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    print('b');
    print(aa.length);
    return aa;
  }

  bool search = false;
  int currentpage = 0;
}
