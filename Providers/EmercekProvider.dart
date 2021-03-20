import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class EmercekProvider extends ChangeNotifier {
  String emercek = '5fa6ea2f1913fb1ae0497b10';
  List<Item> emercekNews = List<Item>();
  int skip = 0;
  Future<List<Item>> getEmercekNews() async {
    Posts posts = await DunyaApiManager()
        .getPostsFromCatagoryIDWithPagination(emercek, 0, 10);
    emercekNews = posts.data.items;
    return emercekNews;
  }

  Future<List<Item>> getMoreEmercekNews() async {
    skip = skip + 10;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(emercek, skip, 10);
      if (posts != null) {
        emercekNews.addAll(posts.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return emercekNews;
  }

  Future<List<Item>> refreshEmercekNews() async {
    skip = 0;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(emercek, 0, 10);

      if (posts != null) {
        emercekNews.clear();
        emercekNews = posts.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return emercekNews;
  }
}
