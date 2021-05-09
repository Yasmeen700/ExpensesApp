import './widget/chart.dart';

import './widget/transaction_list.dart';

import './widget/new_transactions.dart';

import 'package:flutter/material.dart';

import './models/transaction.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quick',
          // textTheme: ThemeData.light().textTheme.copyWith(
          //       // subtitle1: TextStyle(
          //       //   fontFamily: 'OpenSans',
          //       //   fontWeight: FontWeight.bold,
          //       //   fontSize: 18,
          //       // ),
          //   // button: TextStyle(
          //   //   color: Colors.white
          //   // ),
          //     ),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ))),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> transactions = [];

  void _addTransaction(String name, double amount) {
    setState(() {
      transactions
          .add(Transaction(amount: amount, date: DateTime.now(), name: name));
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: AddTransactions(_addTransaction),
        onTap: () {},
      ),
    );
  }

  List<Transaction> get _recentTransactions {
    return transactions
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(_recentTransactions),
          TransactionList(transactions),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
