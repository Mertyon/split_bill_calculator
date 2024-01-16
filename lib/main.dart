import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Split Bill Calculator',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _priceController = TextEditingController();
  TextEditingController _peopleController = TextEditingController();
  TextEditingController _tipController = TextEditingController();

  double _totalAmount = 0.0;

  void _calculateTotalAmount() {
    double price = double.tryParse(_priceController.text) ?? 0.0;
    int people = int.tryParse(_peopleController.text) ?? 1;
    double tipPercentage = double.tryParse(_tipController.text) ?? 0.0;

    double tipAmount = (price * tipPercentage) / 100;
    double totalAmount = price + tipAmount;
    double amountPerPerson = totalAmount / people;

    setState(() {
      _totalAmount = amountPerPerson;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Split Bill Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter the total price in PLN',
                prefixText: 'PLN ',
              ),
            ),
            TextField(
              controller: _peopleController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter the number of people',
              ),
            ),
            TextField(
              controller: _tipController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter the tip percentage',
                suffixText: '%',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
              ),
              onPressed: _calculateTotalAmount,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(
              'Total amount per person: PLN ${_totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
