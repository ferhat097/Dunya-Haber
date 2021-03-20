import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Currency {
  Currency({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  List<Datum> data;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        status: json["status"],
        success: json["success"],
        error: json["error"],
        data: List<Datum>.from(
          json["data"].map(
                (x) => Datum.fromJson(x),
              ),
        ),
      );
}

class Datum {
  Datum(this.name, this.val, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);

  String name;
  int val;
  charts.Color color;

  Datum.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? '-';
    val = json["val"];
    // color = Colors.amber;
  }
}
