class Author {
  Author({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
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
    this.id,
    this.name,
    this.email,
    this.image,
  });

  String id;
  String name;
  String email;
  ImageData image;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"]??'-',
        name: json["name"]??'-',
        email: json["email"]??'-',
        image: ImageData.fromJson(
          json["image"],
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
}
