class Page {
  Page({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
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
    this.content,
    this.link,
  });

  String id;
  String title;
  String content;
  String link;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"]??'-',
        title: json["title"]??'-',
        content: json["content"]??'-',
        link: json["link"]??'-',
      );
}
