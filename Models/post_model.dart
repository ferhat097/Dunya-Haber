class Posts {
  Posts({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        status: json["status"],
        success: json["success"],
        error: json["error"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.skip,
    this.take,
    this.count,
    this.items,
  });

  int skip;
  int take;
  int count;
  List<Item> items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        skip: json["skip"],
        take: json["take"],
        count: json["count"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

class Item {
  Item(
      {this.id,
      this.postType,
      this.link,
      this.title,
      this.summary,
      this.image,
      this.dateTime,
      this.diffrence,
      this.date});

  String id;
  int postType;
  String link;
  String title;
  String summary;
  ImageData image;
  String date;
  DateTime dateTime;
  int diffrence;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"]??'-',
        postType: json["post_type"],
        date: json["published_at"]??'-',
        link: json["link"]??'-',
        title: json["title"]??'-',
        summary: json["summary"],
        image: ImageData.fromJson(json["image"]),
      );
}

class ImageData {
  ImageData({
    this.url,
    this.width,
    this.height,
  });

  String url;
  int width;
  int height;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        url: json["url"]??'-',
        width: json["width"],
        height: json["height"],
      );
}
