class Definitions {
  Definitions({
    this.status,
    this.success,
    this.error,
    this.data,
  });

  int status;
  bool success;
  dynamic error;
  Data data;

  factory Definitions.fromJson(Map<String, dynamic> json) => Definitions(
        status: json["status"],
        success: json["success"],
        error: json["error"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.skip,
    this.take,
    this.count,
    this.items,
  });

  int skip;
  int take;
  int count;
  List<Item> items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        skip: json["skip"],
        take: json["take"],
        count: json["count"],
        items: List<Item>.from(
          json["items"].map(
                (x) => Item.fromJson(x),
              ) ??
              '-',
        ),
      );
}

class Item {
  Item({
    this.id,
    this.code,
    this.name,
    this.shortName,
    this.type,
    this.foreksCode,
    this.exchange,
  });

  String id;
  String code;
  String name;
  String shortName;
  Type type;
  String foreksCode;
  String exchange;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"]??'-',
        code: json["code"]??'-',
        name: json["name"],
        shortName: json["short_name"]??'-',
        type: typeValues.map[json["type"]],
        foreksCode: json["foreks_code"]??'-',
        exchange: json["exchange"]??'-',
      );
}

enum Exchange { GRAND_BAZAAR, BIST, BANK }

final exchangeValues = EnumValues({
  "Bank": Exchange.BANK,
  "BIST": Exchange.BIST,
  "GrandBazaar": Exchange.GRAND_BAZAAR
});

enum Type { CURRENCY, STOCK, INDEX }

final typeValues = EnumValues(
    {"currency": Type.CURRENCY, "stock": Type.STOCK, "index": Type.INDEX});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
