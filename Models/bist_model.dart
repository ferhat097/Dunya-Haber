class Bist {
  Bist({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Bist.fromJson(Map<String, dynamic> json) => Bist(
        status: json["status"],
        success: json["success"],
        error: json["error"],
        data: Data.fromJson(
          json["data"],
        ),
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
    this.dailyVolume,
    this.dailyAmount,
    this.dailyChange,
    this.weeklyChange,
    this.monthlyChange,
    this.yearlyChange,
    this.dailyChangePercentage,
    this.weeklyChangePercentage,
    this.monthlyChangePercentage,
    this.yearlyChangePercentage,
    this.capital,
    this.netCapital,
    this.netProfit,
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
  double dailyVolume;
  int dailyAmount;
  double dailyChange;
  double weeklyChange;
  double monthlyChange;
  double yearlyChange;
  double dailyChangePercentage;
  double weeklyChangePercentage;
  double monthlyChangePercentage;
  double yearlyChangePercentage;
  double capital;
  int netCapital;
  int netProfit;
  DateTime updatedAt;
  DateTime createdAt;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"]??'-',
        code: json["code"]??'-',
        foreksCode: json["foreks_code"]??'-',
        type: json["type"]??'-',
        name: json["name"]??'-',
        shortName: json["short_name"]??'-',
        time: json["time"]??'-',
        value: json["value"].toDouble()??0,
        ask: json["ask"].toDouble()??0,
        bid: json["bid"].toDouble()??0,
        dailyLowest: json["daily_lowest"].toDouble()??0,
        dailyHighest: json["daily_highest"].toDouble()??0,
        weeklyLowest: json["weekly_lowest"].toDouble()??0,
        weeklyHighest: json["weekly_highest"].toDouble()??0,
        monthlyLowest: json["monthly_lowest"].toDouble()??0,
        monthlyHighest: json["monthly_highest"].toDouble()??0,
        dailyVolume: json["daily_volume"].toDouble()??0,
        dailyAmount: json["daily_amount"]??0,
        dailyChange: json["daily_change"].toDouble()??0,
        weeklyChange: json["weekly_change"].toDouble()??0,
        monthlyChange: json["monthly_change"].toDouble()??0,
        yearlyChange: json["yearly_change"].toDouble()??0,
        dailyChangePercentage: json["daily_change_percentage"].toDouble()??0,
        weeklyChangePercentage: json["weekly_change_percentage"].toDouble()??0,
        monthlyChangePercentage: json["monthly_change_percentage"].toDouble()??0,
        yearlyChangePercentage: json["yearly_change_percentage"].toDouble()??0,
        capital: json["capital"].toDouble()??0,
        netCapital: json["net_capital"]??0,
        netProfit: json["net_profit"]??0,
        updatedAt: DateTime.parse(json["updated_at"])??0,
        createdAt: DateTime.parse(json["created_at"])??0,
      );
}
