import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haber/Models/Hisseler.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/chartModel.dart';
import 'package:haber/Models/snapshots.dart';
import 'package:haber/Models/definitions.dart' as Definition;
import 'package:http/http.dart' as http;
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:k_chart/utils/data_util.dart';

class BorsaProvider extends ChangeNotifier {
  Snapshots snapshots;
  Future<Snapshots> getcodeinfo(String codes) async {
    snapshots = await DunyaApiManager().getAllSnapshots(codes);
    notifyListeners();
    return snapshots;
  }

  bool isLine = false;

  List<Hisse> hisseler = List<Hisse>();
  Hisse selectedhisse =
      Hisse('SG14BIL', '14 Ayar Bilezik Gram\/TL', 'GrandBazaar', 'SG14BIL');

  List<KLineEntity> dat = List<KLineEntity>();

  changeVal(value) {
    selectedhisse = value;
    notifyListeners();
  }

  int currentselectedtime = 1;

  changeCurrentSelectedTime(index) {
    currentselectedtime = index;
    notifyListeners();
  }

  changeChartType() {
    isLine = !isLine;
    notifyListeners();
  }

  Future<List<Hisse>> getHisse() async {
    //var url = 'https://www.dunya.com/api/v5/finance/definitions?take=991';
    Definition.Definitions definitions =
        await DunyaApiManager().getAllDefinitions(true);
    definitions.data.items.forEach((element) {
      Hisse hisse = Hisse(
          element.foreksCode, element.name, element.exchange, element.code);
      hisseler.add(hisse);
    });
    notifyListeners();
    return hisseler;
  }

  Future<List<KLineEntity>> getData(String period, String symbol) async {
    var url =
        'https://www.dunya.com/api/v5/finance/chart?foreks_code=$symbol&period=$period';
    /*var url =
        'https://api.huobi.br.com/market/history/kline?period=${time ?? '1day'}&size=400&symbol=${symbol ?? 'btcusdt'}';*/
    var result;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('yess2');
      result = response.body;
    } else {
      print('yess3');
      print('Failed getting IP address');
    }
    //var result = await getIPAddress(time);
    ChartModel chartModel = ChartModel.fromJson(json.decode(result));
    List<Datum> list1 = chartModel.data;
    print(list1);
    dat = list1
        .map((item) => KLineEntity.fromCustom(
            open: item.open,
            close: item.close,
            low: item.low,
            high: item.high,
            amount: 1,
            time: item.date * 1000,
            vol: 1,
            change: 1,
            ratio: 1))
        .toList()
        .reversed
        .toList()
        .cast<KLineEntity>();
    //Map parseJson = json.decode(result);
    // List list = parseJson['data'];
    /* datas = list
        .map((item) => KLineEntity.fromJson(item))
        .toList()
        .reversed
        .toList()
        .cast<KLineEntity>();
*/
    DataUtil.calculate(dat);

    // showLoading = false;
    //controller.sink.add(datas);
    notifyListeners();
    //controller.close();
    return dat;
  }

  Future<dynamic> getIPAddress(String time) async {
    print('yess1');
    var url =
        'https://api.huobi.br.com/market/history/kline?period=${time ?? '1day'}&size=400&symbol=btcusdt';
    //'https://api.huobi.br.com/market/history/kline?period=${period ?? '1day'}&size=400&symbol=${symbl ?? 'btcusdt'}';
    var result;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('yess2');
      result = response.body;
    } else {
      print('yess3');
      print('Failed getting IP address');
    }
    print('yess4');
    return result;
  }
}
