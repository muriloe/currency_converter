import 'package:currency_converter/currency_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'app_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AppController appController = Provider.of<AppController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Currency Converter')),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
            Text('Conversor de moedas'),
            Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                currencybtn(origin: 'from', onClick: (value) async => {getFromCoin(context)}, context: context, currency: appController.coinFrom),
                Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                Icon(Icons.compare_arrows_outlined),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                currencybtn(origin: 'to', onClick: (value) async => {getToCoin(context)}, context: context, currency: appController.coinTo),
              ],
            ),
            inputCurrency(),
            appController.coinFrom != null && appController.coinTo != null ? resultText(appController.coinFrom, '1', appController.coinTo, '2') : Container()
          ],
        ),
      ),
    );
  }
}

getFromCoin(context) async {
  var alias = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CurrencySelectionPage()),
  );
  AppController appController = Provider.of<AppController>(context, listen: false);
  appController.setCoinFrom(alias);
}

getToCoin(context) async {
  var alias = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CurrencySelectionPage()),
  );
  AppController appController = Provider.of<AppController>(context, listen: false);
  appController.setCoinTo(alias);
}

currencybtn({String currency, String origin, onClick, context}) {
  AppController appController = Provider.of<AppController>(context);
  return ButtonTheme(
    minWidth: 150,
    child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: BorderSide(color: Colors.blue)),
        padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
        textColor: Colors.white,
        onPressed: () {
          onClick(origin);
        },
        child: Text(
          currency != null ? currency : 'Selecionar',
          overflow: TextOverflow.clip,
        )),
  );
}

inputCurrency() {
  return Container(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(34, 10, 34, 0),
      child: TextField(
        keyboardType: TextInputType.number,
        minLines: 1,
        maxLines: 1,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: 'Digite o valor',
          filled: true,
          fillColor: Colors.lightBlueAccent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.yellow),
          ),
        ),
      ),
    ),
  );
}

resultText(originCoin, originValue, destinycoin, destinyValue) {
  return Column(
    children: [
      Text('\nResultado da conversão \n'),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(originValue + ' '), Text(originCoin)],
      ),
      Text('='),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            destinyValue + ' ',
            style: TextStyle(fontSize: 35),
          ),
          Text(destinycoin, style: TextStyle(fontSize: 25))
        ],
      ),
    ],
  );
}
