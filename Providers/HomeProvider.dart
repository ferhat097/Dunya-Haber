import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/authors_model.dart' as Author;
import 'package:haber/Models/headline_item.dart' as HeadLine;
import 'package:haber/Models/post_model.dart';

class HomeProvider extends ChangeNotifier {
  TabController controller;

  List<Item> igaNews = List<Item>();
  List<Item> motivasyonNews = List<Item>();
  List<Item> saglikNews = List<Item>();
  double expanded = 370;
  changeexpanded(index) {
    if (index >= 70) {
      expanded = index;
      notifyListeners();
    }
  }

  setfirst(TabController tabController) {
    controller = tabController;
  }

  setCont(TabController tabController) {
    controller = tabController;
    notifyListeners();
  }

  int pageindex = 0;
  changePageindex(index) {
    pageindex = index;
    notifyListeners();
  }

  List<HeadLine.Item> oneCikanlar = List<HeadLine.Item>();
  List<Author.Item> publisher = List<Author.Item>();
  int skip = 0;
  int skipsaglik = 0;
  String dunyaId = '5fa6ea2f1913fb1ae0497ab4';
  String sektorId = '5fa6ea2f1913fb1ae0497ae5';

  String girisimcilik = '5fa6ea2f1913fb1ae0497afc';
  String motivasyonId = '5fa6ea2f1913fb1ae0497b12';
  int locationonecikanlar = 5; 

  Future<List<Author.Item>> getPublisher() async {
    publisher.clear();
    Author.Authors author =
        await DunyaApiManager().getAuthorsWithPagination(0, 15);
    publisher = author.data.items;
    print("ok cleared");
    notifyListeners();
    return publisher;
  }

  Future<List<HeadLine.Item>> getOneCikanlar() async {
    try {
      HeadLine.Headline post =
          await DunyaApiManager().getHeadlineFromLocation(5);
      if (post != null) {
        oneCikanlar.clear();
        oneCikanlar = post.data.items;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return oneCikanlar;
  }

  int currentpage = 0;
  bool search = false;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  changetoall(index) {
    pageController.jumpToPage(index);
    currentpage = index;
    notifyListeners();
  }

  changesearch() {
    search = !search;
    // notifyListeners();
  }

  goback() {
    pageController.previousPage(
        duration: Duration(milliseconds: 50), curve: Curves.ease);
  }
}
