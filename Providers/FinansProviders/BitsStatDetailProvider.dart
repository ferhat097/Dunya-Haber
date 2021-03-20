import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haber/Models/chartModel.dart';
import 'package:http/http.dart' as http;
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:k_chart/utils/data_util.dart';

class BitsStatDetailProvider extends ChangeNotifier {
  List<KLineEntity> dat = List<KLineEntity>();
  bool size = false;
  bool weekly = false;
  bool monthly = false;
  bool yearly = false;
  bool finansqraf = true;
  bool isLine = true;
  changeSize() {
    size = !size;
    notifyListeners();
  }

  changeweekly() {
    weekly = !weekly;
    notifyListeners();
  }

  changemonthly() {
    monthly = !monthly;
    notifyListeners();
  }

  changeyearly() {
    yearly = !yearly;
    notifyListeners();
  }

  changefinansqraf() {
    finansqraf = !finansqraf;
    notifyListeners();
  }

  changeqraftype() {
    isLine = !isLine;
    notifyListeners();
  }

  getData(String symbol, String period) async {
    dat.clear();
    var url =
        'https://www.dunya.com/api/v5/finance/chart?foreks_code=$symbol&period=$period';
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
    //notifyListeners();
    //controller.close();
    return dat;
  }

  changedata(String symbol, String period) async {
    dat.clear();
    var url =
        'https://www.dunya.com/api/v5/finance/chart?foreks_code=$symbol&period=$period';
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
}
