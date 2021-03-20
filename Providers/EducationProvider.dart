import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';

class EducationProvider extends ChangeNotifier {
  List<Item> educationNews = List<Item>();
  String id = '5fa6ea2f1913fb1ae0497abc';
  int skip = 0;
  Future<List<Item>> getEducationNews() async {
    educationNews.clear();
    Posts a =
        await DunyaApiManager().getPostsFromCatagoryIDWithPagination(id, 0, 5);
    educationNews = a.data.items;
    return educationNews;
  }

  Future<List<Item>> getMoreEducationNews() async {
    skip = skip + 5;
    try {
      Posts a = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(id, skip, 5);
      if (a != null) {
        educationNews.addAll(a.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return educationNews;
  }

  Future<List<Item>> refreshEducation() async {
    skip = 0;
    try {
      Posts a = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(id, 0, 5);

      if (a != null) {
        educationNews.clear();
        educationNews = a.data.items;

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    print('b');

    return educationNews;
  }

  bool search = false;
  int currentpage = 0;
 
}
