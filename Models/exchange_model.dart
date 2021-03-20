// To parse this JSON data, do
//
//     final exchanges = exchangesFromJson(jsonString);

import 'dart:convert';

Exchanges exchangesFromJson(String str) => Exchanges.fromJson(json.decode(str));


class Exchanges {
    Exchanges({
        this.status,
        this.success,
        this.error,
        this.data,
    });

    int status;
    bool success;
    dynamic error;
    Data data;

    factory Exchanges.fromJson(Map<String, dynamic> json) => Exchanges(
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

    List<String> items;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: List<String>.from(json["items"].map((x) => x)),
    );
}
