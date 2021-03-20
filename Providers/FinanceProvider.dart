import 'dart:async';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_model.dart';
import 'package:flutter/material.dart';

class FinanceProvider extends ChangeNotifier {
  List<Item> financeNews = List<Item>();
  int skipfinance = 0;
  String finans = '5fa6ea2f1913fb1ae0497ab3';

  Future<List<Item>> getFinanceNews() async {
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(finans, 0, 10);
      if (posts != null) {
        financeNews.clear();

        financeNews = posts.data.items;
      }
    } catch (e) {
      print(e);
    }

    return financeNews;
  }

  Future<List<Item>> getMoreFinanceNews() async {
    skipfinance = skipfinance + 10;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(finans, skipfinance, 10);
      if (posts != null) {
        financeNews.addAll(posts.data.items);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    print('b');
    return financeNews;
  }

  Future<List<Item>> refreshFinanceNews() async {
    skipfinance = 0;
    try {
      Posts posts = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(finans, 0, 10);

      if (posts != null) {
        financeNews.clear();
        financeNews = posts.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return financeNews;
  }

  int currentpage = 0;
  bool search = false;
 
}
