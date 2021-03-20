class Headline {
  Headline({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Headline.fromJson(Map<String, dynamic> json) => Headline(
        status: json["status"],
        success: json["success"],
        error: json["error"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.count,
    this.items,
  });

  int count;
  List<Item> items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"]??'-',
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x),),),
      );
}

class Item {
  Item({
    this.id,
    this.postType,
    this.link,
    this.title,
    this.summary,
    this.image,
    this.showTextOnImage,
  });

  String id;
  int postType;
  String link;
  String title;
  String summary;
  Image image;
  bool showTextOnImage;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"]??'-',
        postType: json["post_type"],
        link: json["link"]??'-',
        title: json["title"]??'-',
        summary: json["summary"]??'-',
        image: Image.fromJson(json["image"]),
        showTextOnImage: json["show_text_on_image"],
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
