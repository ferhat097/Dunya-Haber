import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class OzelProvider extends ChangeNotifier {
  String ozelDosyalar = '5fa6ea2f1913fb1ae0497ab8';
  List<Item> ozelNews = List<Item>();
  int skip = 0;
  Future<List<Item>> getOzelNews() async {
    Posts posts = await DunyaApiManager()
        .getPostsFromCatagoryIDWithPagination(ozelDosyalar, 0, 10);
    ozelNews = posts.data.items;
    return ozelNews;
  }

  Future<List<Item>> getMoreOzelNews() async {
    skip = skip + 10;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(ozelDosyalar, skip, 10);
      if (posts != null) {
        ozelNews.addAll(posts.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return ozelNews;
  }

  Future<List<Item>> refreshOzelNews() async {
    skip = 0;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(ozelDosyalar, 0, 10);

      if (posts != null) {
        ozelNews.clear();
        ozelNews = posts.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return ozelNews;
  }
}
