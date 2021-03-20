class Catagories {
  Catagories({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Catagories.fromJson(Map<String, dynamic> json) => Catagories(
        status: json["status"],
        success: json["success"],
        error: json["error"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.type,
    this.parentId,
    this.count,
    this.items,
  });

  int type;
  int parentId;
  int count;
  List<Item> items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        parentId: json["parent_id"],
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
    this.parentId,
  });

  String id;
  String name;
  int parentId;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"] ?? '-',
        name: json["name"] ?? '-',
        parentId: json["parent_id"],
      );
}
