class Pages {
  Pages({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
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
        count: json["count"],
        items: List<Item>.from(
          json["items"].map(
                (x) => Item.fromJson(x),
              ) ??
              '-',
        ),
      );
}

class Item {
  Item({
    this.id,
    this.title,
  });

  String id;
  String title;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"]??'-',
        title: json["title"]??'-',
      );
}
