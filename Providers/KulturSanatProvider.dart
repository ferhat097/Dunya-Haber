import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class KulturSanatProvider extends ChangeNotifier {
  String kulturSanatid = '5fa6ea2f1913fb1ae0497abd';
  List<Item> kulturSanat = List<Item>();
  int skip = 0;
  Future<List<Item>> getKulturSanat() async {
    Posts posts = await DunyaApiManager()
        .getPostsFromCatagoryIDWithPagination(kulturSanatid, 0, 10);
    kulturSanat = posts.data.items;
    return kulturSanat;
  }

  Future<List<Item>> getMoreKulturSanat() async {
    skip = skip + 10;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(kulturSanatid, skip, 10);
      if (posts != null) {
        kulturSanat.addAll(posts.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return kulturSanat;
  }

  Future<List<Item>> refreshKulturSanat() async {
    skip = 0;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(kulturSanatid, 0, 10);

      if (posts != null) {
        kulturSanat.clear();
        kulturSanat = posts.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return kulturSanat;
  }
}
