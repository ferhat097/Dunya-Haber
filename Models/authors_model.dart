class Authors {
  Authors({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Authors.fromJson(Map<String, dynamic> json) => Authors(
        status: json["status"],
        success: json["success"],
        error: json["error"],
        data: Data.fromJson(
          json["data"],
        ),
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
        items: List<Item>.from(
          json["items"].map(
            (x) => Item.fromJson(x),
          ),
        ),
      );
}

class Item {
  Item({
    this.id,
    this.name,
    this.email,
    this.image,
    this.lastPost,
  });

  String id;
  String name;
  String email;
  ImageData image;
  LastPost lastPost;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"]??'-',
        name: json["name"]??'-',
        email: json["email"]??'-',
        image: ImageData.fromJson(json["image"]),
        lastPost: LastPost.fromJson(
          json["last_post"],
        ),
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

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}

class LastPost {
  LastPost({
    this.id,
    this.postType,
    this.title,
  });

  String id;
  int postType;
  String title;

  factory LastPost.fromJson(Map<String, dynamic> json) => LastPost(
        id: json["id"]??'-',
        postType: json["post_type"],
        title: json["title"]??'-',
      );
}
