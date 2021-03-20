class Charts {
  Charts({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  List<Datum> data;

  factory Charts.fromJson(Map<String, dynamic> json) => Charts(
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
  Datum({
    this.date,
    this.value,
  });

  int date;
  double value;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"],
        value: json["value"].toDouble(),
      );
}
