import 'dart:io';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/post_item.dart';
import 'package:haber/Models/savedPost.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveController {
  initHive() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(SavedPostAdapter());
    await Hive.openBox<SavedPost>('posts');
  }

  dispose() async {
    await Hive.close();
  }

  controlled() {}
  savePost(Post post) {
    SavedPost convertetArticle = convert(post);
    Box posts = Hive.box<SavedPost>('posts');
    posts.add(convertetArticle);
  }

  savePostWithItem(item) async {
    Post post = await DunyaApiManager().getPost(item.id);
    SavedPost convertetArticle = convert(post);
    Box posts = Hive.box<SavedPost>('posts');
    posts.add(convertetArticle);
  }

  deletePost(key) async {
    Box<SavedPost> posts = Hive.box<SavedPost>('posts');
    await posts.delete(key);
  }

  deletePostWithID(item) async {
    Box<SavedPost> posts = Hive.box<SavedPost>('posts');
    Map<dynamic, SavedPost> postmap = posts.toMap();
    postmap.forEach(
      (key, postfrommap) async {
        if (item.id == postfrommap.id) {
          await posts.delete(key);
        }
      },
    );
  }

  List<SavedPost> getAllPosts() {
    return Hive.box<SavedPost>('posts').toMap().values.toList();
  }

  @deprecated
  SavedPost getPostAt(int index) {
    Box<SavedPost> posts = Hive.box<SavedPost>('posts');
    return posts.get(index);
  }

  int itemCount() {
    Box<SavedPost> posts = Hive.box<SavedPost>('posts');
    return posts.length;
  }

  bool checkIfSaved(Post post) {
    bool saved = false;
    Box<SavedPost> articles = Hive.box<SavedPost>('posts');
    Map<dynamic, SavedPost> postsmap = articles.toMap();
    postsmap.forEach(
      (key, postfrommap) {
        if (post.data.id == postfrommap.id) {
          saved = true;
        }
      },
    );
    return saved;
  }

  SavedPost convert(Post post) {
    return SavedPost(
        title: post.data.title ?? "-",
        id: post.data.id ?? "-",
        categoryName: post.data.category.name ?? "-",
        contentHtml: post.data.contentHtml ?? "-",
        editorName: post.data.editor.name ?? "-",
        imageUrl: post.data.image.url ?? "-",
        link: post.data.link ?? "-",
        postType: String.fromCharCode(post.data.postType ?? "-"),
        publishedAt: post.data.publishedAt ?? "-",
        summary: post.data.summary ?? "-",
        updatedAt: post.data.updatedAt ?? "-",
        // videoEmbedCode: post.data.video.embedCode.toString,
        videoUrl: post.data.video.url ?? "-");
  }
}
