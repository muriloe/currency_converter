import 'dart:convert';

import 'package:currency_converter/coin_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AppController extends ChangeNotifier {
  String apiKey = '46c6cfaea256e53df0d6ae13d109eb0c';
  List<CoinModel> coins = [];
  String coinFrom;
  String coinTo;
  String valueToConvert;
  String result;

  AppController() {
    getCoins();
  }

  getCoins() async {
    coins = List<CoinModel>();
    var result = await http.get('http://api.currencylayer.com/list?access_key=' + apiKey);
    var parsedJson = json.decode(result.body);
    var coinsMap = parsedJson['currencies'];
    coinsMap.forEach((alias, name) => {coins.add(CoinModel(name: name, alias: alias))});
    notifyListeners();
  }

  setCoinFrom(String alias) {
    coinFrom = alias;
    notifyListeners();
  }

  setCoinTo(String alias) {
    coinTo = alias;
    notifyListeners();
  }
}
