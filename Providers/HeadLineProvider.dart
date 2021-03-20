import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/headline_item.dart' as HeadLine;

class HeadLineProvider extends ChangeNotifier {
  List<HeadLine.Item> electedNews = List<HeadLine.Item>();
  int dotposition = 0;
  dotPosition(slider) {
    dotposition = slider;
    notifyListeners();
  }

  Future<List<HeadLine.Item>> getElectedNews() async {
    HeadLine.Headline post = await DunyaApiManager().getHeadlineFromLocation(2);
    electedNews.clear();
    electedNews = post.data.items;
    print(electedNews.length);
    notifyListeners();
    return electedNews;
  }
}
