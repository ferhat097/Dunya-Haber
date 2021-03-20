import 'dart:convert';
import 'package:haber/Models/user_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiManager {
  signIn(String email, String pass) async {
    print('loading');
    Map<String, dynamic> data = {'email': email, 'password': pass};
    var jsonData;
    User user;
    SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      var response =
          await post('https://abone.dunya.com/api/login', body: data);
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        if (jsonData['status'] == 1) {
          //succes
          user = User.fromJson(jsonData);
          await sp.setString('token', user.data.token);
          await sp.setString('name', user.data.name);
          await sp.setInt('id', user.data.id);
          await sp.setString('email', user.data.email);
          print(sp.getString('token'));
        } else {
          print(jsonData['message']);
        }
      } else if (response.statusCode == 400) {
        //No such user
        print('No such user');
      }
    } catch (e) {
      print(e);
    }
  }

  register(String email, String pass, String name) async {
    print('loading');
    Map data = {'email': email, 'password': pass, 'name': name};
    var jsonData;
    User user;
    SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      var response =
          await post('https://abone.dunya.com/api/register', body: data);
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        if (jsonData['status'] == 1) {
          //succes
          user = User.fromJson(jsonData);
          await sp.setString('token', user.data.token);
          await sp.setString('name', user.data.name);
          await sp.setInt('id', user.data.id);
          await sp.setString('email', user.data.email);
          print(sp.getString('token'));
        } else {
          print(jsonData['message']);
        }
      } else if (response.statusCode == 400) {
        print('Missing components');
      } else {
        print('Error');
      }
    } catch (e) {}
  }

  // ignore: missing_return
  Future<String> resetPass(String email) async {
    print('loading');
    var jsonData;
    Map data = {'email': email};
    try {
      var response =
          await post('https://abone.dunya.com/api/reset-password', body: data);
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        if (jsonData['status'] == 1) {
          // succes
          print(jsonData['message']);
          return jsonData['message'];
        } else {
          print(jsonData['message']);
          return jsonData['message'];
        }
      } else if (response.statusCode == 400) {
        print('Missing components');
        return 'Missing components';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getString('token') == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> getUserToken() async {
    var userAvaible = await checkLoginStatus();
    if (userAvaible) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      return sp.getString('token');
    } else {
      return null;
    }
  }

  Future<Map> getUserData() async {
    var userAvaible = await checkLoginStatus();
    if (userAvaible) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      Map<String, dynamic> data = Map<String, dynamic>();
      data['email'] = sp.getString('email');
      data['name'] = sp.getString('name');
      data['token'] = sp.getString('token');
      data['id'] = sp.getInt('id');
      return data;
    } else {
      print('No user avaible');
      return null;
    }
  }
}
