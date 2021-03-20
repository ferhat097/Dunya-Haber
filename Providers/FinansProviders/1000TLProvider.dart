import 'package:flutter/material.dart';
import 'package:haber/Service/dunya_api.dart';
import 'package:haber/Models/currency.dart';

class Provider1000TL extends ChangeNotifier {
  List<Datum> currencylist = List<Datum>();
  int currentselected1000tl = 1;
  changecurrentselected1000tl(index) {
    currentselected1000tl = index;
    notifyListeners();
  }

  List namme = [
    'DOLAR\n \$',
    'EURO\n €',
    'BİST\n 100',
    'ALTIN\n (gr)',
    'ALTIN\n (ons)',
    'PETROL\n (Brent)'
  ];
  Future<List<Datum>> getData(String period) async {
    Currency currency = await DunyaApiManager().getCurrency(period);
    if (currency != null) {
      currency.data.asMap().forEach((key, value) {
        value.name = namme[key];
        currencylist.add(value);
      });
      /* currency.data.forEach((element) {
        /* if (element.val > 1000) {
          element.color = Colors.green[400] as Color;
        }
          else{
            element.color = Colors.red[400] as Color;
          }*/
        //element.color = Colors.red as Color;
        
      });*/
    }
    notifyListeners();
    return currencylist;
  }
}
