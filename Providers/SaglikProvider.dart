import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class SaglikProvider extends ChangeNotifier {
  String saglikId = '5fa6ea2f1913fb1ae0497abe';
  List<Item> saglikNews = List<Item>();
  int skip = 0;
  Future<List<Item>> getSaglikNews() async {
    Posts posts = await DunyaApiManager()
        .getPostsFromCatagoryIDWithPagination(saglikId, 0, 10);
    saglikNews = posts.data.items;
    return saglikNews;
  }

  Future<List<Item>> getMoreSaglikNews() async {
    skip = skip + 10;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(saglikId, skip, 10);
      if (posts != null) {
        saglikNews.addAll(posts.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return saglikNews;
  }

  Future<List<Item>> refreshSaglikNews() async {
    skip = 0;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(saglikId, 0, 10);

      if (posts != null) {
        saglikNews.clear();
        saglikNews = posts.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return saglikNews;
  }
}
