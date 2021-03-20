import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/headline_item.dart' as HeadLine;
import 'package:haber/Models/authors_model.dart' as Author;
import 'package:haber/Models/post_item.dart';
import 'package:haber/Models/post_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class DetailProvider extends ChangeNotifier {
  bool search = false;
  double pageOffset = 0;
  int index2;
  double contentfontsize = 15;
  bool more = true;
  int skip;
  String newsid;
  IndexController controllerindex = IndexController();
  List<Item> news = List<Item>();
  List<Post> post = List<Post>();
  List<HeadLine.Item> newsHead = List<HeadLine.Item>();
  List<Author.Item> authors = List<Author.Item>();
  IndexController get indxcntr => controllerindex;
  lis(index) {
    controllerindex.move(index, animation: false);
  }

  bool get moree => more;
  getmore() async {
    more = false;
    try {
      Posts a = await DunyaApiManager()
          .getPostsFromCatagoryIDWithPagination(newsid, skip, 5);
      if (a != null) {
        news.addAll(a.data.items);
        skip = skip + 5;
      }
      more = true;
    } catch (e) {
      print(e);
    }


    notifyListeners();
  }

  void setfirstpost(List<dynamic> list, int skipdata, String id, String type) {
    if (type == 'headline') {
      newsHead = list;
    } else if (type == 'author') {
      authors = list;
    } else {
      news = list;
      skip = skipdata + 5;
      newsid = id;
    }
  }

  increasefontsize(double count) {
    if (contentfontsize < 30) {
      contentfontsize = contentfontsize + count;

      notifyListeners();
    }
  }

  Future<List<Post>> getPost(List<Item> posts) async {
    for (var id in posts) {
      DateTime dateTime;
      int diffrence;
      Post singleNews = await DunyaApiManager().getPost(id.id);
      await initializeDateFormatting('tr_TR', null).then((_) {
        var dateapi = singleNews.data.publishedAt;
        //final dateAsString = '10 Mart 2021 16:38';
        final format = new DateFormat('dd MMMM yyyy HH:mm', 'tr_TR');
        dateTime = format.parse(dateapi);
        DateTime now = DateTime.now();
        diffrence = now.difference(dateTime).inMinutes;
        //print(diffrence);
      });
      singleNews.data.dateTime = dateTime;
      singleNews.data.diffrence = diffrence;
      post.add(singleNews);
    }
    notifyListeners();

    return post;
  }

  Future<Post> getpost(id) async {
    Post singleNews = await DunyaApiManager().getPost(id);
    return singleNews;
  }

  decreasefontsize(double count) {
    if (contentfontsize > 10) {
      contentfontsize = contentfontsize - count;
      notifyListeners();
    }
  }

  int currentpage = 0;
  changesearch() {}
  goback() {}
  changetoall(index) {}
}
