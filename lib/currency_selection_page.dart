import 'package:currency_converter/app_controller.dart';
import 'package:currency_converter/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencySelectionPage extends StatefulWidget {
  @override
  _CurrencySelectionPageState createState() => _CurrencySelectionPageState();
}

class _CurrencySelectionPageState extends State<CurrencySelectionPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider<AppController>.value(value: AppController())],
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Selecione a moeda')),
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
    );
  }
}
