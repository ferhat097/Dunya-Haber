class Source {
  Source({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
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
    this.fullName,
  });

  String id;
  String name;
  String fullName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"]??'-',
        name: json["name"]??'-',
        fullName: json["full_name"]??'-',
      );
}
