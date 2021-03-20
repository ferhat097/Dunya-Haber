import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

class Post {
  Post({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        status: json["status"],
        success: json["success"],
        error: json["error"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.id,
    this.title,
    this.summary,
    this.link,
    this.postType,
    this.editor,
    this.author,
    this.source,
    this.publishedAt,
    this.updatedAt,
    this.image,
    this.category,
    this.tags,
    this.topics,
    this.contentHtml,
    this.gallery,
    this.video,
  });

  String id;
  String title;
  dynamic summary;
  String link;
  int postType;
  Editor editor;
  List<dynamic> author;
  List<dynamic> source;
  String publishedAt;
  String updatedAt;
  Image image;
  Category category;
  List<dynamic> tags;
  List<dynamic> topics;
  String contentHtml;
 List<Gallery> gallery;
  Video video;
  DateTime dateTime;
  int diffrence;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"]??'-',
      title: json["title"]??'-',
      summary: json["summary"]??'-',
      link: json["link"]??'-',
      postType: json["post_type"],
     // editor: Editor.fromJson(json["editor"] ?? "no data"),
      //author: List<dynamic>.from(json["author"]?.map((x) => x)),
      //source: List<dynamic>.from(json["source"]?.map((x) => x)),
      publishedAt: json["published_at"],
      updatedAt: json["updated_at"]??'-',
      image: Image.fromJson(json["image"]),
      //category: Category.fromJson(json["category"] ?? "no data"),
      tags: List<dynamic>.from(json["tags"]?.map((x) => x)),
      topics: List<dynamic>.from(json["topics"]?.map((x) => x)),
      contentHtml: json["content_html"]??'-',
      /* gallery:
            List<Gallery>.from(json["gallery"]?.map((x) => Gallery.fromJson(x))),*/
      video: Video.fromJson(json["video"]),
    );
  }
}

class Category {
  Category({
    this.id,
    this.name,
    this.link,
  });

  String id;
  String name;
  String link;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"]??'-',
        name: json["name"]??'-',
        link: json["link"]??'-',
      );
}

class Editor {
  Editor({
    this.id,
    this.name,
    this.email,
    this.image,
    this.link,
  });

  String id;
  String name;
  String email;
  List<dynamic> image;
  String link;

  factory Editor.fromJson(Map<String, dynamic> json) => Editor(
        id: json["id"]??'-',
        name: json["name"]??'-',
        email: json["email"]??'-',
        image: List<dynamic>.from(json["image"].map((x) => x)),
        link: json["link"]??'-',
      );
}

class Gallery {
  Gallery({
    this.url,
    this.summaryHtml,
  });

  String url;
  String summaryHtml;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        url: json["url"]??'-',
        summaryHtml: json["summary_html"]??'-',
      );
}

class Image {
  Image({
    this.url,
    this.width,
    this.height,
  });

  String url;
  int width;
  int height;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"]??'-',
        width: json["width"],
        height: json["height"],
      );
}

class Video {
  Video({
    this.url,
    this.embedCode,
  });

  dynamic url;
  dynamic embedCode;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        url: json["url"]??'-',
        embedCode: json["embed_code"]??'-',
      );
}
