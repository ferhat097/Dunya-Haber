class Topic {
  Topic({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        status: json["status"],
        success: json["success"],
        error: json["error"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"]??'-',
        name: json["name"]??'-',
      );
}
