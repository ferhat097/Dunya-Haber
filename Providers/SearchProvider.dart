import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class SearchProvider extends ChangeNotifier {
  List<Item> searchresult = List<Item>();
  int skip = 0;
  TextEditingController controller;
  String query;
  setquery(text) {
    query = text;
  }

  moreSearch(query) async {
    skip = skip + 10;
    try {
      Posts post =
          await DunyaApiManager().searchPostsWithPagination(query, skip, 10);
      if (post != null) {
        searchresult.addAll(post.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  search(query) async {
    searchresult.clear();
    try {
      skip = 0;
      Posts post =
          await DunyaApiManager().searchPostsWithPagination(query, 0, 10);
      if (post != null) {
        searchresult = post.data.items;

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return searchresult;
  }
}
