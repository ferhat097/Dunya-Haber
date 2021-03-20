class User {
  User({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.token,
  });

  int id;
  String name;
  String email;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"]??'-',
        email: json["email"]??'-',
        token: json["token"]??'-',
      );
}