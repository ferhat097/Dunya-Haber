import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class RamazanProvider extends ChangeNotifier {
  String ramazanid = '5fa6ea2f1913fb1ae0497aff';
  List<Item> ramazanNews = List<Item>();
  int skip = 0;
  Future<List<Item>> getRamazanNews() async {
    Posts posts = await DunyaApiManager()
        .getPostsFromCatagoryIDWithPagination(ramazanid, 0, 10);
    ramazanNews = posts.data.items;
    return ramazanNews;
  }

  Future<List<Item>> getMoreRamazanNews() async {
    skip = skip + 10;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(ramazanid, skip, 10);
      if (posts != null) {
        ramazanNews.addAll(posts.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return ramazanNews;
  }

  Future<List<Item>> refreshRamazanNews() async {
    skip = 0;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(ramazanid, 0, 10);

      if (posts != null) {
        ramazanNews.clear();
        ramazanNews = posts.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return ramazanNews;
  }
}
