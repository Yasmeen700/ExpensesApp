import 'package:universal_io/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

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
          ),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _transactions = [];

  void _addTransaction(String name, double amount, DateTime chosenDate) {
    setState(() {
      _transactions.add(Transaction(
          amount: amount,
          date: chosenDate,
          name: name,
          id: DateTime.now().toString(),),);
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
    return _transactions
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  bool _switchVal = false;

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _switchVal,
              onChanged: (val) {
                setState(() {
                  _switchVal = val;
                });
              }),
        ],
      ),
      _switchVal
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : txWidget,
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txWidget) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txWidget,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: const Text('Personal Expenses'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
    final txWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_transactions, _deleteTransaction),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              ..._buildLandscapeContent(mediaQuery, appBar, txWidget),
            if (!isLandscape)
              ..._buildPortraitContent(mediaQuery, appBar, txWidget),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
