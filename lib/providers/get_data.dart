import 'dart:convert';

import 'package:order_food/model/cemilan_model.dart';
import 'package:order_food/model/menu_model.dart';
import 'package:http/http.dart' as http;
import 'package:order_food/model/minuman_model.dart';

class GetData {
  static Future<List<MenuModel>> getMakanan() async {
    final String url =
        "https://script.google.com/macros/s/AKfycbyrYTcTqDxNENhMTq8AvXUgw5Twe3N3ghmsLdpDjt045REa_1C5KXV7va7tA7Bt4bBMoA/exec";
    List<MenuModel> listMenu = [];
    var response = await http.get(Uri.parse(url));
    List data = jsonDecode(response.body);

    for (var element in data) {
      listMenu.add(MenuModel.fromJson(element));
    }
    return listMenu;
  }

  static Future<List<MinumModel>> getMinuman() async {
    final String url =
        "https://script.google.com/macros/s/AKfycbx6PTOAvVbD9Le7zrlDu6P3qSZVFx5C_4MntEFEt84Rv746PUal4t-rP3ARRPjW38miWA/exec";
    List<MinumModel> listMenu = [];
    var response = await http.get(Uri.parse(url));
    List data = jsonDecode(response.body);

    for (var element in data) {
      listMenu.add(MinumModel.fromJson(element));
    }
    return listMenu;
  }

  static Future<List<CemilanModel>> getCemilan() async {
    final String url =
        "https://script.google.com/macros/s/AKfycbz-82R7wLuOPzyCbDZEP3DkY8WoaL0LCJ6cA7h9LJocpTDmIqPJOw8VzYPyoioQSR7tKw/exec";
    List<CemilanModel> listMenu = [];
    var response = await http.get(Uri.parse(url));
    List data = jsonDecode(response.body);

    for (var element in data) {
      listMenu.add(CemilanModel.fromJson(element));
    }
    return listMenu;
  }

  static Future<void> getRefresh() {
    return Future.delayed(
        Duration(
          seconds: 2,
        ),
        () async {});
  }
}
