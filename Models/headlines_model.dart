class Headlines {
  Headlines({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Headlines.fromJson(Map<String, dynamic> json) => Headlines(
        status: json["status"],
        success: json["success"],
        error: json["error"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.items,
  });

  List<Item> items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: List<Item>.from(
          json["items"].map(
            (x) => Item.fromJson(x),
          ),
        ),
      );
}

class Item {
  Item({
    this.location,
    this.name,
  });

  int location;
  String name;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        location: json["location"],
        name: json["name"] ?? '-',
      );
}
