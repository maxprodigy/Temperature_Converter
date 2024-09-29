import 'package:flutter/material.dart';

void main() => runApp(TemperatureConverterApp());

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  double _inputTemperature = 0.0;
  String _convertedResult = '';
  String _conversionType = 'C to F';
  final List<String> _conversionHistory = [];

  // Fahrenheit to Celsius conversion
  double _convertFahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  // Celsius to Fahrenheit conversion
  double _convertCelsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  // Conversion Logic
  void _performConversion() {
    setState(() {
      if (_conversionType == 'C to F') {
        double result = _convertCelsiusToFahrenheit(_inputTemperature);
        _convertedResult =
            '${_inputTemperature.toStringAsFixed(2)} °C => ${result.toStringAsFixed(2)} °F';
      } else {
        double result = _convertFahrenheitToCelsius(_inputTemperature);
        _convertedResult =
            '${_inputTemperature.toStringAsFixed(2)} °F => ${result.toStringAsFixed(2)} °C';
      }
      _conversionHistory.add(_convertedResult);
    });
  }

  // UI components like TextFields, Radio Buttons, Buttons, etc.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temperature Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Enter Temperature'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _inputTemperature = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 10),
            RadioListTile(
              title: const Text('Celsius to Fahrenheit'),
              value: 'C to F',
              groupValue: _conversionType,
              onChanged: (value) {
                setState(() {
                  _conversionType = value!;
                });
              },
            ),
            RadioListTile(
              title: const Text('Fahrenheit to Celsius'),
              value: 'F to C',
              groupValue: _conversionType,
              onChanged: (value) {
                setState(() {
                  _conversionType = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _performConversion,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _convertedResult.isNotEmpty ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Text(
                'Converted Temperature: $_convertedResult',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const Divider(),
            const Text(
              'Conversion History:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _conversionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_conversionHistory[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
