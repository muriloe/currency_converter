import 'dart:convert';

import 'package:currency_converter/coin_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AppController extends ChangeNotifier {
  String apiKey = '46c6cfaea256e53df0d6ae13d109eb0c';
  List<CoinModel> coins = [];
  String coinFrom;
  String coinTo;
  double valueToConvert;
  double result;
  double baseValueUsdFrom;
  double baseValueUsdTo;

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

  getUsdValue(alias) async {
    if (alias == "USD") {
      return 1.0;
    } else {
      coins = List<CoinModel>();
      var result = await http.get('http://api.currencylayer.com/live?access_key=' + apiKey + '&currencies=' + alias);
      var parsedJson = json.decode(result.body);
      var coinsMap = parsedJson['quotes'];
      var valueResult;
      coinsMap.forEach((alias, name) => {valueResult = name});
      return valueResult;
    }
  }

  setCoinFrom(String alias) async {
    coinFrom = alias;
    baseValueUsdFrom = await getUsdValue(alias);
    calculateResult();
    notifyListeners();
  }

  setCoinTo(String alias) async {
    coinTo = alias;
    baseValueUsdTo = await getUsdValue(alias);
    calculateResult();
    notifyListeners();
  }

  calculateResult() {
    if (coinFrom != null && coinTo != null && valueToConvert != null) {
      result = baseValueUsdTo / baseValueUsdFrom * valueToConvert;
      notifyListeners();
    }
  }
}
