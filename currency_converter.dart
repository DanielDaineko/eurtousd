import 'package:flutter/material.dart';
import 'api_service.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  double eurToUsd = 0.0;
  bool loading = true;
  bool eurToUsdDirection = true; // true для EUR к USD, false для USD к EUR
  final ApiService _apiService = ApiService();

  void fetchExchangeRate() async {
    try {
      double rate = await _apiService.getExchangeRate();
      setState(() {
        eurToUsd = rate;
        loading = false;
      });
    } catch (e) {
      print('Ошибка при загрузке обменного курса: $e');
      // Обработка ошибки
    }
  }

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Конвертер валюты'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                loading = true;
              });
              fetchExchangeRate();
            },
          ),
        ],
      ),
      body: loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                eurToUsdDirection ? '1 EUR = $eurToUsd USD' : '1 USD = ${1 / eurToUsd} EUR',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    eurToUsdDirection = !eurToUsdDirection;
                  });
                },
                child: Text(eurToUsdDirection ? 'Переключить на USD к EUR' : 'Переключить на EUR к USD'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
