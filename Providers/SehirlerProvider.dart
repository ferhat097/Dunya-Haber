import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class SehirlerProvider extends ChangeNotifier {
  String sehirlerId = '5fa6ea2f1913fb1ae0497ac8';
  List<Item> sehirlerNews = List<Item>();
  int skip = 0;
  Future<List<Item>> getSehirlerNews() async {
    Posts posts = await DunyaApiManager()
        .getPostsFromCatagoryIDWithPagination(sehirlerId, 0, 10);
    sehirlerNews = posts.data.items;
    return sehirlerNews;
  }

  Future<List<Item>> getMoreSehirlerNews() async {
    skip = skip + 10;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(sehirlerId, skip, 10);
      if (posts != null) {
        sehirlerNews.addAll(posts.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return sehirlerNews;
  }

  Future<List<Item>> refreshSehirlerNews() async {
    skip = 0;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(sehirlerId, 0, 10);

      if (posts != null) {
        sehirlerNews.clear();
        sehirlerNews = posts.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return sehirlerNews;
  }
}
