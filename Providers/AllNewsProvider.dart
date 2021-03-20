import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class AllNewsProvider extends ChangeNotifier {
  List<Item> allNews = List<Item>();
  int skip = 0;
  Future<List<Item>> getAllNews() async {
    Posts post = await DunyaApiManager().getPostsWithPagination(0, 10);
    allNews.clear();
    allNews = post.data.items;
    print(allNews.length);
    notifyListeners();
    return allNews;
  }

  Future<List<Item>> getMoreAllNews() async {
    skip = skip + 10;
    try {
      Posts post = await DunyaApiManager().getPostsWithPagination(skip, 10);
      if (post != null) {
        allNews.addAll(post.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return allNews;
  }

  Future<List<Item>> refreshAllNews() async {
    try {
      Posts post = await DunyaApiManager().getPostsWithPagination(0, 10);

      if (post != null) {
        allNews.clear();
        allNews.addAll(post.data.items);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    skip = 10;
    return allNews;
  }
}
