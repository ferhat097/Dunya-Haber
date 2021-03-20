import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class YasamProvider extends ChangeNotifier {
  String yasamId = '5fa6ea2f1913fb1ae0497ade';
  List<Item> yasamNews = List<Item>();
  int skip = 0;
  Future<List<Item>> getYasamNews() async {
    Posts posts = await DunyaApiManager()
        .getPostsFromCatagoryIDWithPagination(yasamId, 0, 10);
    yasamNews = posts.data.items;
    return yasamNews;
  }

  Future<List<Item>> getMoreYasamNews() async {
    skip = skip + 10;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(yasamId, skip, 10);
      if (posts != null) {
        yasamNews.addAll(posts.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return yasamNews;
  }

  Future<List<Item>> refreshYasamNews() async {
    skip = 0;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(yasamId, 0, 10);

      if (posts != null) {
        yasamNews.clear();
        yasamNews = posts.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return yasamNews;
  }
}
