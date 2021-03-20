class Snapshots {
  Snapshots({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Snapshots.fromJson(Map<String, dynamic> json) => Snapshots(
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

  Items items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: Items.fromJson(json["items"]),
      );
}

class Items {
  Items({
    this.scad,
  });

  List<Scad> scad;

  factory Items.fromJson(Map<String, dynamic> json) =>
      Items(scad: List<Scad>.from(json.values.map((x) => Scad.fromJson(x))));
}

class Scad {
  Scad({
    this.id,
    this.code,
    this.foreksCode,
    this.type,
    this.name,
    this.shortName,
    this.time,
    this.value,
    this.ask,
    this.bid,
    this.dailyLowest,
    this.dailyHighest,
    this.weeklyLowest,
    this.weeklyHighest,
    this.monthlyLowest,
    this.monthlyHighest,
    this.dailyChange,
    this.weeklyChange,
    this.monthlyChange,
    this.yearlyChange,
    this.dailyChangePercentage,
    this.weeklyChangePercentage,
    this.monthlyChangePercentage,
    this.yearlyChangePercentage,
    this.updatedAt,
    this.createdAt,
  });

  String id;
  String code;
  String foreksCode;
  String type;
  String name;
  String shortName;
  String time;
  double value;
  double ask;
  double bid;
  double dailyLowest;
  double dailyHighest;
  double weeklyLowest;
  double weeklyHighest;
  double monthlyLowest;
  double monthlyHighest;
  double dailyChange;
  double weeklyChange;
  double monthlyChange;
  double yearlyChange;
  double dailyChangePercentage;
  double weeklyChangePercentage;
  double monthlyChangePercentage;
  double yearlyChangePercentage;
  DateTime updatedAt;
  DateTime createdAt;

  factory Scad.fromJson(Map<String, dynamic> json) => Scad(
        id: json["_id"]??'-',
        code: json["code"]??'-',
        foreksCode: json["foreks_code"]??'-',
        type: json["type"]??'-',
        name: json["name"]??'-',
        shortName: json["short_name"]??'-',
        time: json["time"]??'-',
        value: json["value"].toDouble(),
        ask: json["ask"].toDouble(),
        bid: json["bid"].toDouble(),
        dailyLowest: json["daily_lowest"].toDouble(),
        dailyHighest: json["daily_highest"].toDouble(),
        weeklyLowest: json["weekly_lowest"].toDouble(),
        weeklyHighest: json["weekly_highest"].toDouble(),
        monthlyLowest: json["monthly_lowest"].toDouble(),
        monthlyHighest: json["monthly_highest"].toDouble(),
        dailyChange: json["daily_change"].toDouble(),
        weeklyChange: json["weekly_change"].toDouble(),
        monthlyChange: json["monthly_change"].toDouble(),
        yearlyChange: json["yearly_change"].toDouble(),
        dailyChangePercentage: json["daily_change_percentage"].toDouble(),
        weeklyChangePercentage: json["weekly_change_percentage"].toDouble(),
        monthlyChangePercentage: json["monthly_change_percentage"].toDouble(),
        yearlyChangePercentage: json["yearly_change_percentage"].toDouble(),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
      );
}
