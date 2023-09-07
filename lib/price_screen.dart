import 'package:bitcoin/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'crypto_card.dart';
//import 'dart:io' show Platform;
//import 'package:http/http.dart' as http;

// String? selectedCurrency = 'USD';
// String apikey = '3F802539-3AAA-4D5F-90D3-B0AFC10DBFD5';
// String coinApi = 'https://rest.coinapi.io/v1/exchangerate';
// String selectedCrypto = 'BTC';
// var url =
//     Uri.parse('$coinApi/$selectedCrypto/$selectedCurrency?apikey=$apikey');
// String? rate;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';

// android dropdown button
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var itemList = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(itemList);
    }

    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (
          value,
        ) {
          setState(() {
            selectedCurrency = value!;

            getData();
          });
        });
  }

// specific iOS dropdown button
  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) {},
      children: pickerItems,
    );
  }

  //12. Create a variable to hold the value and use in our Text Widget. Give the variable a starting value of '?' before the data comes back from the async methods.
  //String bitcoinValue = '?';

  //11. Create an async method here await the coin data from coin_data.dart
  //value had to be updated into a Map to store the values of all three cryptocurrencies.
  Map<String, String> coinValues = {};
  //7: Figure out a way of displaying a '?' on screen while we're waiting for the price data to come back. First we have to create a variable to keep track of when we're waiting on the request to complete.
  bool isWaiting = false;
  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      //13. We can't await in a setState(). So you have to separate it out into two steps.
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    //14. Call getData() when the screen loads up. We can't call CoinData().getCoinData() directly here because we can't make initState() async.
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Bitoin Ticker'),
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Image.network(
            'https://images.unsplash.com/photo-1508919801845-fc2ae1bc2a28?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1nfGVufDB8fDB8fHww&w=1000&q=80',
            height: 20000,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          cryptoCard(
              value: isWaiting ? '?' : coinValues['BTC'],
              selectedCurrency: selectedCurrency,
              cryptoCurrency: 'BTC'),
          cryptoCard(
            value: isWaiting ? '?' : coinValues['ETH'],
            selectedCurrency: selectedCurrency,
            cryptoCurrency: 'ETH',
          ),
          cryptoCard(
              cryptoCurrency: 'LTC',
              value: isWaiting ? '?' : coinValues['LTC'],
              selectedCurrency: selectedCurrency),
          Container(
            height: 100.0,

            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            // platform specific wigets : if it is IOS use iosPicker() func elase use androidDropdoun() func
            //child: Platform.isIOS ? iOSPicker() : androidDropdown(),
            child: androidDropdown(),
          ),
        ],
      ),
    );
  }
}
