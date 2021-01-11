import 'package:currency_converter/app_controller.dart';
import 'package:currency_converter/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencySelectionPage extends StatefulWidget {
  final String origin;

  const CurrencySelectionPage({Key key, this.origin}) : super(key: key);
  @override
  _CurrencySelectionPageState createState() => _CurrencySelectionPageState(origin);
}

class _CurrencySelectionPageState extends State<CurrencySelectionPage> {
  final String origin;

  _CurrencySelectionPageState(this.origin);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider<AppController>.value(value: AppController())],
        child: Scaffold(
          appBar: AppBar(
            title: Text('Selecione a moeda'),
          ),
          body: Container(
            child: Consumer<AppController>(
              builder: (context, appController, widger) {
                return buildList(appController);
              },
            ),
          ),
        ));
  }

  buildList(AppController appController) {
    return ListView.builder(
      itemCount: appController.coins.length,
      itemBuilder: (context, index) {
        return listItem(appController.coins[index]);
      },
    );
  }

  listItem(CoinModel coin) {
    return ListTile(
      title: Text(coin.name),
      trailing: Text(coin.alias),
      onTap: () {
        Navigator.pop(context, coin.alias);
      },
    );
  }
}
