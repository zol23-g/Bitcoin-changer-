import 'package:flutter/material.dart';

class cryptoCard extends StatelessWidget {
  const cryptoCard({
    super.key,
    this.value,
    this.cryptoCurrency,
    this.selectedCurrency,
  });
  final String? value;
  final String? selectedCurrency;
  final String? cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          //color: Color.fromARGB(255, 16, 19, 17),
          color: Colors.cyan,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Center(
              child: Text(
                '1 $cryptoCurrency = $value $selectedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
