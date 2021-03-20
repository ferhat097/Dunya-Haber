import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class GundemProvider extends ChangeNotifier {
  List<Item> gundemNews = List<Item>();
  String gundemId = '5fa6ea2f1913fb1ae0497ab7';
  int skipgundem = 0;

  Future<List<Item>> getGundem() async {
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(gundemId, 0, 10);
      if (posts != null) {
        gundemNews.clear();
        gundemNews = posts.data.items;
      }
    } catch (e) {
      print(e);
    }

    return gundemNews;
  }

  Future<List<Item>> getMoreGundem() async {
    skipgundem = skipgundem + 10;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(gundemId, skipgundem, 10);
      if (posts != null) {
        gundemNews.addAll(posts.data.items);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return gundemNews;
  }

  Future<List<Item>> refreshGundemNews() async {
    skipgundem = 0;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(gundemId, 0, 10);
      if (posts != null) {
        gundemNews.clear();
        gundemNews = posts.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return gundemNews;
  }
}
