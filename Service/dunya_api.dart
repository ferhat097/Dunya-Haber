import 'dart:convert';
import 'package:haber/Service/strings.dart';
import 'package:haber/Models/author_item.dart';
import 'package:haber/Models/authors_model.dart';
import 'package:haber/Models/bist_model.dart';
import 'package:haber/Models/catagory_model.dart';
import 'package:haber/Models/charts.dart';
import 'package:haber/Models/currency.dart';
import 'package:haber/Models/definitions.dart';
import 'package:haber/Models/exchange_model.dart';
import 'package:haber/Models/headline_item.dart';
import 'package:haber/Models/headlines_model.dart';
import 'package:haber/Models/page_item.dart';
import 'package:haber/Models/page_model.dart';
import 'package:haber/Models/post_item.dart';
import 'package:haber/Models/post_model.dart';
import 'package:haber/Models/snapshots.dart';
import 'package:haber/Models/source_item.dart';
import 'package:haber/Models/topic_item.dart';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DunyaApiManager {
  //
  init() {
    //set int for post and author pagination in provider
  }
  //
  Future<Posts> getPostsWithPagination(int skip, int take) async {
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response =
          await get('${Strings.baseUrl}/posts?skip=${skip ?? 0}&take=$take');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes

        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          for (var item in postsModel.data.items) {
            DateTime dateTime;
            int diffrence;

            print(item.date);
            await initializeDateFormatting('tr_TR', null).then((_) {
              var dateapi = item.date;
              //final dateAsString = '10 Mart 2021 16:38';
              final format = new DateFormat('dd MMMM yyyy HH:mm', 'tr_TR');
              dateTime = format.parse(dateapi);
              DateTime now = DateTime.now();
              diffrence = now.difference(dateTime).inMinutes;
              //print(diffrence);
            });
            item.dateTime = dateTime;
            item.diffrence = diffrence;
          }

          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> getNewsPostsWithPagination() async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response =
          await get('${Strings.baseUrl}/posts?post_type=0&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> getPhotoGalleryPostsWithPagination() async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response =
          await get('${Strings.baseUrl}/posts?post_type=1&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> getVideoPostsWithPagination() async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response =
          await get('${Strings.baseUrl}/posts?post_type=2&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> getQoutePostsWithPagination() async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response =
          await get('${Strings.baseUrl}/posts?post_type=3&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> getPostsFromCatagoryIDWithPagination(
      String id, int skip, int take) async {
    // skip = privoder.skip
    Posts postsModel;

    try {
      var response = await get(
          '${Strings.baseUrl}/posts?category_id=$id&skip=${skip ?? 0}&take=${take ?? 5}');

      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          for (var item in postsModel.data.items) {
            DateTime dateTime;
            int diffrence;
            await initializeDateFormatting('tr_TR', null).then((_) {
              var dateapi = item.date;
              //final dateAsString = '10 Mart 2021 16:38';
              final format = new DateFormat('dd MMMM yyyy HH:mm', 'tr_TR');
              dateTime = format.parse(dateapi);
              DateTime now = DateTime.now();
              diffrence = now.difference(dateTime).inMinutes;
              //print(diffrence);
            });
            item.dateTime = dateTime;
            item.diffrence = diffrence;
          }
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> getPostsFromTagWithPagination(String tag) async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response =
          await get('${Strings.baseUrl}/posts?tag=$tag&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> getPostsFromTopicIDWithPagination(String id) async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response =
          await get('${Strings.baseUrl}/posts?topic_id=$id&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> getPostsFromEditorIDWithPagination(String id) async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response = await get(
          '${Strings.baseUrl}/posts?editor_id=$id&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> getPostsFromAuthorIDWithPagination(String id) async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response = await get(
          '${Strings.baseUrl}/posts?author_id=$id&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> getPostsFromSourceIDWithPagination(String id) async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response = await get(
          '${Strings.baseUrl}/posts?source_id=$id&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> getPostsOnMainPageWithPagination(int skip, int take) async {
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response = await get(
          '${Strings.baseUrl}/posts?show_on_mainpage=true&skip=$skip&take=$take');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> getPostsNotInSortingsWithPaginatio(String id) async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response = await get(
          '${Strings.baseUrl}posts?not_in_sortings=$id&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> getPostsExcludeWithPaginatio(String id) async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response =
          await get('${Strings.baseUrl}posts?exclude=$id&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  @deprecated
  Future<Posts> getNewsPostsFromCatagoryIDWithPagination(String id) async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response = await get(
          '${Strings.baseUrl}/posts?category_id=$id&post_type=0&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  @deprecated
  Future<Posts> getPhotoGalleryPostsFromCatagoryIDWithPagination(
      String id) async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response = await get(
          '${Strings.baseUrl}/posts?category_id=$id&post_type=1&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  @deprecated
  Future<Posts> getVideoPostsFromCatagoryIDWithPagination(String id) async {
    int skip = 0;
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response = await get(
          '${Strings.baseUrl}/posts?category_id=$id&post_type=2&skip=$skip&take=10');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          //print(postsModel.data.items[1].title);
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Pages> getPages() async {
    Pages pagesModel;
    try {
      var response = await get('${Strings.baseUrl}/pages');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        pagesModel = Pages.fromJson(json.decode(jsonString));
        if (pagesModel.success) {
          //print(postsModel.data.items[1].title);
          return pagesModel;
        } else {
          //error
          print(pagesModel.error.toString());
          return pagesModel;
        }
      } else {
        return pagesModel;
      }
    } catch (e) {
      print(e.toString);
      return pagesModel;
    }
  }

  Future<Headlines> getHeadlines() async {
    Headlines headlinesModel;
    try {
      var response = await get('${Strings.baseUrl}/headlines');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        headlinesModel = Headlines.fromJson(json.decode(jsonString));
        if (headlinesModel.success) {
          //print(postsModel.data.items[1].title);
          return headlinesModel;
        } else {
          //error
          print(headlinesModel.error.toString());
          return headlinesModel;
        }
      } else {
        return headlinesModel;
      }
    } catch (e) {
      print(e.toString);
      return headlinesModel;
    }
  }

  Future<Catagories> getNewsCatagories() async {
    Catagories catagoriesModel;
    try {
      var response = await get('${Strings.baseUrl}/categories?type=1');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        catagoriesModel = Catagories.fromJson(json.decode(jsonString));
        if (catagoriesModel.success) {
          //print(postsModel.data.items[1].title);
          return catagoriesModel;
        } else {
          //error
          print(catagoriesModel.error.toString());
          return catagoriesModel;
        }
      } else {
        return catagoriesModel;
      }
    } catch (e) {
      print(e.toString);
      return catagoriesModel;
    }
  }

  Future<Catagories> getPhotoGalleryCatagories() async {
    Catagories catagoriesModel;
    try {
      var response = await get('${Strings.baseUrl}/categories?type=2');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        catagoriesModel = Catagories.fromJson(json.decode(jsonString));
        if (catagoriesModel.success) {
          //print(postsModel.data.items[1].title);
          return catagoriesModel;
        } else {
          //error
          print(catagoriesModel.error.toString());
          return catagoriesModel;
        }
      } else {
        return catagoriesModel;
      }
    } catch (e) {
      print(e.toString);
      return catagoriesModel;
    }
  }

  Future<Catagories> getVideoCatagories() async {
    Catagories catagoriesModel;
    try {
      var response = await get('${Strings.baseUrl}/categories?type=3');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        catagoriesModel = Catagories.fromJson(json.decode(jsonString));
        if (catagoriesModel.success) {
          //print(postsModel.data.items[1].title);
          return catagoriesModel;
        } else {
          //error
          print(catagoriesModel.error.toString());
          return catagoriesModel;
        }
      } else {
        return catagoriesModel;
      }
    } catch (e) {
      print(e.toString);
      return catagoriesModel;
    }
  }

  Future<Catagories> getCatagoriesFromParent(String parentID) async {
    Catagories catagoriesModel;
    try {
      var response =
          await get('${Strings.baseUrl}/categories?parent_id=$parentID');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        catagoriesModel = Catagories.fromJson(json.decode(jsonString));
        if (catagoriesModel.success) {
          //print(postsModel.data.items[1].title);
          return catagoriesModel;
        } else {
          //error
          print(catagoriesModel.error.toString());
          return catagoriesModel;
        }
      } else {
        return catagoriesModel;
      }
    } catch (e) {
      print(e.toString);
      return catagoriesModel;
    }
  }

  Future<Catagories> getNewsCatagoriesFromParent(String parentID) async {
    Catagories catagoriesModel;
    try {
      var response =
          await get('${Strings.baseUrl}/categories?type=1&parent_id=$parentID');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        catagoriesModel = Catagories.fromJson(json.decode(jsonString));
        if (catagoriesModel.success) {
          //print(postsModel.data.items[1].title);
          return catagoriesModel;
        } else {
          //error
          print(catagoriesModel.error.toString());
          return catagoriesModel;
        }
      } else {
        return catagoriesModel;
      }
    } catch (e) {
      print(e.toString);
      return catagoriesModel;
    }
  }

  Future<Catagories> getPhotoGalleryCatagoriesFromParent(
      String parentID) async {
    Catagories catagoriesModel;
    try {
      var response =
          await get('${Strings.baseUrl}/categories?type=2&parent_id=$parentID');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        catagoriesModel = Catagories.fromJson(json.decode(jsonString));
        if (catagoriesModel.success) {
          //print(postsModel.data.items[1].title);
          return catagoriesModel;
        } else {
          //error
          print(catagoriesModel.error.toString());
          return catagoriesModel;
        }
      } else {
        return catagoriesModel;
      }
    } catch (e) {
      print(e.toString);
      return catagoriesModel;
    }
  }

  Future<Catagories> getVideoCatagoriesFromParent(String parentID) async {
    Catagories catagoriesModel;
    try {
      var response =
          await get('${Strings.baseUrl}/categories?type=3&parent_id=$parentID');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        catagoriesModel = Catagories.fromJson(json.decode(jsonString));
        if (catagoriesModel.success) {
          //print(postsModel.data.items[1].title);
          return catagoriesModel;
        } else {
          //error
          print(catagoriesModel.error.toString());
          return catagoriesModel;
        }
      } else {
        return catagoriesModel;
      }
    } catch (e) {
      print(e.toString);
      return catagoriesModel;
    }
  }

  Future<Headline> getHeadlineFromLocation(int location) async {
    Headline headlineModel;
    try {
      var response =
          await get('${Strings.baseUrl}/headlines?location=$location');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        headlineModel = Headline.fromJson(json.decode(jsonString));
        if (headlineModel.success) {
          //print(postsModel.data.items[1].title);
          return headlineModel;
        } else {
          //error
          print(headlineModel.error.toString());
          return headlineModel;
        }
      } else {
        return headlineModel;
      }
    } catch (e) {
      print(e.toString);
      return headlineModel;
    }
  }

  Future<Authors> getAuthorsWithPagination(int skip, int take) async {
    // skip = privoder.skip
    Authors authorsModel;
    try {
      var response =
          await get('${Strings.baseUrl}/authors?skip=$skip&take=$take');
      //
      // increment  by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        authorsModel = Authors.fromJson(json.decode(jsonString));
        if (authorsModel.success) {
          //print(postsModel.data.items[1].title);
          return authorsModel;
        } else {
          //error
          print(authorsModel.error.toString());
          return authorsModel;
        }
      } else {
        return authorsModel;
      }
    } catch (e) {
      print(e.toString);
      return authorsModel;
    }
  }

  Future<Source> getSource(String id) async {
    Source sourceModel;
    try {
      var response = await get('${Strings.baseUrl}/source/$id');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        sourceModel = Source.fromJson(json.decode(jsonString));
        if (sourceModel.success) {
          return sourceModel;
        } else {
          //error
          print(sourceModel.error.toString());
        }
        return sourceModel;
      } else {
        return sourceModel;
      }
    } catch (e) {
      print(e.toString);
      return sourceModel;
    }
  }

  Future<Author> getAuthor(String id) async {
    Author authorModel;
    try {
      var response = await get('${Strings.baseUrl}/author/$id');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        authorModel = Author.fromJson(json.decode(jsonString));
        if (authorModel.success) {
          return authorModel;
        } else {
          //error
          print(authorModel.error.toString());
          return authorModel;
        }
      } else {
        return authorModel;
      }
    } catch (e) {
      print(e.toString);
      return authorModel;
    }
  }

  Future<Topic> getTopic(String id) async {
    Topic topicModel;
    try {
      var response = await get('${Strings.baseUrl}/topic/$id');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        topicModel = Topic.fromJson(json.decode(jsonString));
        if (topicModel.success) {
          return topicModel;
        } else {
          //error
          print(topicModel.error.toString());
          return topicModel;
        }
      } else {
        return topicModel;
      }
    } catch (e) {
      print(e.toString);
      return topicModel;
    }
  }

  Future<Post> getPost(String id) async {
    Post postModel;
    try {
      var response = await get('${Strings.baseUrl}/posts/$id');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postModel = Post.fromJson(json.decode(jsonString));
        if (postModel.success) {
          return postModel;
        } else {
          //error
          print(postModel.error.toString());
          return postModel;
        }
      } else {
        return postModel;
      }
    } catch (e) {
      print(e.toString);
      return postModel;
    }
  }

  Future<Page> getPage(String id) async {
    Page pageModel;
    try {
      var response = await get('${Strings.baseUrl}/pages/$id');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        pageModel = Page.fromJson(json.decode(jsonString));
        if (pageModel.success) {
          return pageModel;
        } else {
          //error
          print(pageModel.error.toString());
          return pageModel;
        }
      } else {
        return pageModel;
      }
    } catch (e) {
      print(e.toString);
      return pageModel;
    }
  }

  Future<Posts> searchPostsWithPagination(
      String search, int skip, int take) async {
    // skip = privoder.skip
    Posts postsModel;
    try {
      var response = await get(
          '${Strings.baseUrl}/search?skip=$skip&take=$take&query=$search');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          for (var item in postsModel.data.items) {
            DateTime dateTime;
            int diffrence;
            await initializeDateFormatting('tr_TR', null).then((_) {
              var dateapi = item.date;
              //final dateAsString = '10 Mart 2021 16:38';
              final format = new DateFormat('dd MMMM yyyy HH:mm', 'tr_TR');
              dateTime = format.parse(dateapi);
              DateTime now = DateTime.now();
              diffrence = now.difference(dateTime).inMinutes;
              //print(diffrence);
            });
            item.dateTime = dateTime;
            item.diffrence = diffrence;
          }
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Posts> searchPosts(String search) async {
    Posts postsModel;
    try {
      var response =
          await get('${Strings.baseUrl}/search?take=10&query=$search');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        postsModel = Posts.fromJson(json.decode(jsonString));
        if (postsModel.success) {
          return postsModel;
        } else {
          //error
          print(postsModel.error.toString());
          return postsModel;
        }
      } else {
        return postsModel;
      }
    } catch (e) {
      print(e.toString);
      return postsModel;
    }
  }

  Future<Exchanges> getExchanges() async {
    Exchanges exchanges;
    try {
      var response = await get('${Strings.baseUrl}/finance/exchanges');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        exchanges = Exchanges.fromJson(json.decode(jsonString));
        if (exchanges.success) {
          return exchanges;
        } else {
          //error
          print(exchanges.error.toString());
          return exchanges;
        }
      } else {
        return exchanges;
      }
    } catch (e) {
      print(e.toString);
      return exchanges;
    }
  }

  Future<Bist> getBIST(bool increasing) async {
    String type;
    increasing ? type = 'increasing' : type = 'decreasing';

    Bist bist;
    try {
      var response =
          await get('${Strings.baseUrl}/finance/bist-stats?type=$type');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        bist = Bist.fromJson(json.decode(jsonString));
        if (bist.success) {
          return bist;
        } else {
          //error
          print(bist.error.toString());
          return bist;
        }
      } else {
        return bist;
      }
    } catch (e) {
      print(e.toString);
      return bist;
    }
  }

  Future<Bist> getMostTradedBIST() async {
    Bist bist;
    try {
      var response =
          await get('${Strings.baseUrl}/finance/bist-stats?type=most-traded');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        bist = Bist.fromJson(json.decode(jsonString));
        if (bist.success) {
          return bist;
        } else {
          //error
          print(bist.error.toString());
          return bist;
        }
      } else {
        return bist;
      }
    } catch (e) {
      print(e.toString);
      return bist;
    }
  }

  Future<Definitions> getAllDefinitions(bool descending) async {
    String order;
    descending ? order = 'code.desc' : order = 'code.asc';

    //types = stock, currency, index, tahvil, repo
    //exchanges = "BIST","Bank","GrandBazaar","SPOT","TCMB"

    Definitions definitions;
    try {
      var response = await get(
          '${Strings.baseUrl}/finance/definitions?skip=0&take=991&order_by=$order');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        definitions = Definitions.fromJson(json.decode(jsonString));
        if (definitions.success) {
          return definitions;
        } else {
          //error
          print(definitions.error.toString());
          return definitions;
        }
      } else {
        return definitions;
      }
    } catch (e) {
      print(e.toString);
      return definitions;
    }
  }

  Future<Definitions> getAllDefinitionsWithPagination(bool descending) async {
    String order;
    descending ? order = 'code.desc' : order = 'code.asc';

    //types = stock, currency, index, tahvil, repo
    //exchanges = "BIST","Bank","GrandBazaar","SPOT","TCMB"

    int skip = 0;
    // skip = privoder.skip
    Definitions definitions;
    try {
      var response = await get(
          '${Strings.baseUrl}/finance/definitions?skip=$skip&take=10&order_by=$order');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        definitions = Definitions.fromJson(json.decode(jsonString));
        if (definitions.success) {
          return definitions;
        } else {
          //error
          print(definitions.error.toString());
          return definitions;
        }
      } else {
        return definitions;
      }
    } catch (e) {
      print(e.toString);
      return definitions;
    }
  }

  Future<Definitions> getDefinitions(
      String type, String exchange, bool descending) async {
    String order;
    descending ? order = 'code.desc' : order = 'code.asc';

    //types = stock, currency, index, tahvil, repo
    //exchanges = "BIST","Bank","GrandBazaar","SPOT","TCMB"

    Definitions definitions;
    try {
      var response = await get(
          '${Strings.baseUrl}/finance/definitions?skip=0&take=10&type=$type&exchange=$exchange&order_by=$order');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        definitions = Definitions.fromJson(json.decode(jsonString));
        if (definitions.success) {
          return definitions;
        } else {
          //error
          print(definitions.error.toString());
          return definitions;
        }
      } else {
        return definitions;
      }
    } catch (e) {
      print(e.toString);
      return definitions;
    }
  }

  Future<Definitions> getDefinitionsWithPagination(
      String type, String exchange, bool descending) async {
    String order;
    descending ? order = 'code.desc' : order = 'code.asc';

    //types = stock, currency, index, tahvil, repo
    //exchanges = "BIST","Bank","GrandBazaar","SPOT","TCMB"

    int skip = 0;
    // skip = privoder.skip
    Definitions definitions;
    try {
      var response = await get(
          '${Strings.baseUrl}/finance/definitions?skip=$skip&take=10&type=$type&exchange=$exchange&order_by=$order');
      //
      // increment skip by 10
      //
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        definitions = Definitions.fromJson(json.decode(jsonString));
        if (definitions.success) {
          return definitions;
        } else {
          //error
          print(definitions.error.toString());
          return definitions;
        }
      } else {
        return definitions;
      }
    } catch (e) {
      print(e.toString);
      return definitions;
    }
  }

  Future<Snapshots> getAllSnapshots(String codes) async {
    Snapshots snapshots;
    try {
      var response =
          await get('${Strings.baseUrl}/finance/snapshots?codes=$codes');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        snapshots = Snapshots.fromJson(json.decode(jsonString));
        if (snapshots.success) {
          return snapshots;
        } else {
          //error
          print(snapshots.error.toString());
          return snapshots;
        }
      } else {
        return snapshots;
      }
    } catch (e) {
      print(e.toString);
      return snapshots;
    }
  }

  Future<Snapshots> getSnapshots(
      String codes, String type, bool descending) async {
    String order;
    descending ? order = 'weight.desc' : order = 'weight.asc';

    //types = stock, currency, index, tahvil, repo

    Snapshots snapshots;
    try {
      var response = await get(
          '${Strings.baseUrl}/finance/snapshots?type=$type&order_by=$order&codes=$codes');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        snapshots = Snapshots.fromJson(json.decode(jsonString));
        if (snapshots.success) {
          return snapshots;
        } else {
          //error
          print(snapshots.error.toString());
          return snapshots;
        }
      } else {
        return snapshots;
      }
    } catch (e) {
      print(e.toString);
      return snapshots;
    }
  }

  Future<Currency> getCurrency(String period) async {
    //
    //period = daily, weekly, monthly, yearly
    //

    Currency currency;
    try {
      var response =
          await get('${Strings.baseUrl}/finance/currency-value?period=$period');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        currency = Currency.fromJson(json.decode(jsonString));
        if (currency.success) {
          return currency;
        } else {
          //error
          print(currency.error.toString());
          return currency;
        }
      } else {
        return currency;
      }
    } catch (e) {
      print(e.toString);
      return currency;
    }
  }

  Future<Charts> getChart(
      String period, bool isLinear, String foreksCode) async {
    //
    //period = daily, weekly, monthly, 3months, 6months, yearly, 5years
    //
    String type;
    isLinear ? type = 'line' : type = 'candle';

    Charts charts;
    try {
      var response = await get(
          '${Strings.baseUrl}/finance/chart?foreks_code=$foreksCode&period=$period&type=$type');
      if (response.statusCode == 200) {
        //succes
        var jsonString = response.body;
        charts = Charts.fromJson(json.decode(jsonString));
        if (charts.success) {
          return charts;
        } else {
          //error
          print(charts.error.toString());
          return charts;
        }
      } else {
        return charts;
      }
    } catch (e) {
      print(e.toString);
      return charts;
    }
  }
}
