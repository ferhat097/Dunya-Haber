import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:haber/Service/login_manager.dart';
import 'package:haber/Models/current_rate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {
  List<CurrentRate> currentRate = List<CurrentRate>();
  bool loggedin = false;
  Map<String, dynamic> test = {'name': 'bilgi yok', 'email': 'bilgi yok'};
  Map<dynamic, dynamic> data = Map<dynamic, dynamic>();

  Future<void> logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('token');
    await sp.remove('id');
    await sp.remove('email');
    await sp.remove('name');
    await checklogin();
  }

  Future<void> checklogin() async {
    loggedin = await ApiManager().checkLoginStatus();
    if (loggedin) {
      data = await ApiManager().getUserData();
    }
    notifyListeners();
    //return loggedin;
  }

  Future<List<CurrentRate>> getCurrentRate() async {
    currentRate.clear();
    CurrentRate currentRate1 = CurrentRate("Borsa", 1.550, null);
    CurrentRate currentRate2 = CurrentRate("Dolar", 7.331, true);
    CurrentRate currentRate3 = CurrentRate("Euro", 8.732, false);
    CurrentRate currentRate4 = CurrentRate("Altın (Ons)", 1.730, false);
    CurrentRate currentRate5 = CurrentRate("Brent", 63.690, true);
    currentRate.add(currentRate1);
    currentRate.add(currentRate2);
    currentRate.add(currentRate3);
    currentRate.add(currentRate4);
    currentRate.add(currentRate5);
    return currentRate;
  }

  int page = 2;
  GlobalKey<InnerDrawerState> globalKey = GlobalKey<InnerDrawerState>();
  GlobalKey<NavigatorState> navstate = GlobalKey<NavigatorState>();

  bottomnavigate(index) {
    page = index;
    notifyListeners();
  }
}
