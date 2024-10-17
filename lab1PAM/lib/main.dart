import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(CurrencyConverterApp());

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String _fromCurrency = 'MDL';
  String _toCurrency = 'USD';
  double _inputAmount = 1000;
  double _convertedAmount = 0;

  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'RUB', 'AUD', 'CAD', 'MDL'];

  final Map<String, Map<String, double>> _exchangeRates = {
    'USD': {'EUR': 0.85, 'GBP': 0.75, 'RUB': 75.0, 'AUD': 1.35, 'CAD': 1.25, 'MDL': 17.65},
    'EUR': {'USD': 1.18, 'GBP': 0.88, 'RUB': 88.0, 'AUD': 1.60, 'CAD': 1.47, 'MDL': 20.75},
    'GBP': {'USD': 1.33, 'EUR': 1.14, 'RUB': 100.0, 'AUD': 1.80, 'CAD': 1.60, 'MDL': 27.55},
    'RUB': {'USD': 0.013, 'EUR': 0.011, 'GBP': 0.01, 'AUD': 0.018, 'CAD': 0.016, 'MDL': 0.23},
    'AUD': {'USD': 0.74, 'EUR': 0.63, 'GBP': 0.56, 'RUB': 55.0, 'CAD': 0.93, 'MDL': 14.45},
    'CAD': {'USD': 0.80, 'EUR': 0.68, 'GBP': 0.63, 'RUB': 70.0, 'AUD': 1.08, 'MDL': 15.50},
    'MDL': {'USD': 0.057, 'EUR': 0.048, 'GBP': 0.036, 'RUB': 4.4, 'AUD': 0.069, 'CAD': 0.064},
  };

  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _inputController.text = _inputAmount.toStringAsFixed(2);
    _convertCurrency();
  }

  void _convertCurrency() {
    setState(() {
      _inputAmount = double.tryParse(_inputController.text) ?? 0;
      double exchangeRate = _exchangeRates[_fromCurrency]![_toCurrency] ?? 1.0;
      _convertedAmount = _inputAmount * exchangeRate;
      _outputController.text = _convertedAmount.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Currency Converter'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.blue[900],
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            _buildCurrencyCard(),
            SizedBox(height: 30),
            _buildExchangeRateLabel(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                _buildCurrencyDropdown(_fromCurrency, (value) {
                  setState(() {
                    _fromCurrency = value!;
                    _convertCurrency();
                  });
                }),
                SizedBox(width: 10),
                Expanded(
                  child: _buildAmountField(
                    _inputController,
                        (value) {
                      _convertCurrency();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            IconButton(
              icon: Icon(Icons.sync, size: 30, color: Colors.purple),
              onPressed: _convertCurrency,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                _buildCurrencyDropdown(_toCurrency, (value) {
                  setState(() {
                    _toCurrency = value!;
                    _convertCurrency();
                  });
                }),
                SizedBox(width: 10),
                Expanded(
                  child: _buildAmountField(
                    _outputController,
                    null,
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown(String value, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: value,
      onChanged: onChanged,
      items: _currencies.map((String currency) {
        return DropdownMenuItem<String>(
          value: currency,
          child: Row(
            children: [
              Image.asset(
                'assets/flags/$currency.png',
                width: 30,
                height: 30,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.flag),
              ),
              SizedBox(width: 10),
              Text(currency),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAmountField(TextEditingController controller, ValueChanged<String>? onChanged, {bool readOnly = false}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildExchangeRateLabel() {
    return Column(
      children: [
        Text(
          'Indicative Exchange Rate',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '1 $_fromCurrency = ${_exchangeRates[_fromCurrency]![_toCurrency]?.toStringAsFixed(2) ?? 'N/A'} $_toCurrency',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
