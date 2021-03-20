import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class IGAnewsProvider extends ChangeNotifier {
  String iganewsid = '5fa6ea2f1913fb1ae0497b02';

  List<Item> iGAnews = List<Item>();
  int skip = 0;
  Future<List<Item>> getIGAnews() async {
    Posts posts = await DunyaApiManager()
        .getPostsFromCatagoryIDWithPagination(iganewsid, 0, 10);
    iGAnews = posts.data.items;
    return iGAnews;
  }

  Future<List<Item>> getMoreIGAnews() async {
    skip = skip + 10;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(iganewsid, skip, 10);
      if (posts != null) {
        iGAnews.addAll(posts.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return iGAnews;
  }

  Future<List<Item>> refreshIGAnews() async {
    skip = 0;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(iganewsid, 0, 10);

      if (posts != null) {
        iGAnews.clear();
        iGAnews = posts.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return iGAnews;
  }
}
