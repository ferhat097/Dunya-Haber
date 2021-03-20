import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class EkonomiProvider extends ChangeNotifier {
  String ekonomiId = '5fa6ea2f1913fb1ae0497ab2';
  List<Item> ekonomiNews = List<Item>();
  int skip = 0;
  Future<List<Item>> getEkonomiNews() async {
    Posts posts = await DunyaApiManager()
        .getPostsFromCatagoryIDWithPagination(ekonomiId, 0, 10);
    ekonomiNews = posts.data.items;
    return ekonomiNews;
  }

  Future<List<Item>> getMoreEkonomiNews() async {
    skip = skip + 10;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(ekonomiId, skip, 10);
      if (posts != null) {
        ekonomiNews.addAll(posts.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return ekonomiNews;
  }

  Future<List<Item>> refreshEkonomiNews() async {
    skip = 0;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(ekonomiId, 0, 10);

      if (posts != null) {
        ekonomiNews.clear();
        ekonomiNews = posts.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return ekonomiNews;
  }
}
