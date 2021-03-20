// To parse this JSON data, do
//
//     final chartModel = chartModelFromJson(jsonString);

import 'dart:convert';

ChartModel chartModelFromJson(String str) => ChartModel.fromJson(json.decode(str));


class ChartModel {
    ChartModel({
        this.status,
        this.success,
        this.error,
        this.data,
    });

    int status;
    bool success;
    dynamic error;
    List<Datum> data;

    factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
        status: json["status"],
        success: json["success"],
        error: json["error"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );
}

class Datum {
    Datum({
        this.date,
        this.open,
        this.high,
        this.low,
        this.close,
    });

    int date;
    double open;
    double high;
    double low;
    double close;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"],
        open: json["open"].toDouble(),
        high: json["high"].toDouble(),
        low: json["low"].toDouble(),
        close: json["close"].toDouble(),
    );
}
