import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class SirketProvider extends ChangeNotifier {
  String sirkethaberlerId = '5fa6ea2f1913fb1ae0497abb';
  List<Item> sirketNews = List<Item>();
  int skip = 0;
  Future<List<Item>> getSirketNews() async {
    Posts posts = await DunyaApiManager()
        .getPostsFromCatagoryIDWithPagination(sirkethaberlerId, 0, 10);
    sirketNews = posts.data.items;
    return sirketNews;
  }

  Future<List<Item>> getMoreSirketNews() async {
    skip = skip + 10;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(sirkethaberlerId, skip, 10);
      if (posts != null) {
        sirketNews.addAll(posts.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return sirketNews;
  }

  Future<List<Item>> refreshSirketNews() async {
    skip = 0;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(sirkethaberlerId, 0, 10);

      if (posts != null) {
        sirketNews.clear();
        sirketNews = posts.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return sirketNews;
  }
}
