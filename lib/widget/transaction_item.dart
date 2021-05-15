
import 'dart:math';

import 'package:intl/intl.dart';

import '../models/transaction.dart';

import 'package:flutter/material.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.userTransaction,
    @required this.deleteTransactions,
  }) : super(key: key);

  final Transaction userTransaction;
  final Function deleteTransactions;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: FittedBox(
              child: Padding(
                  padding: EdgeInsets.all(6),
                  child:
                  Text('\$${widget.userTransaction.amount}'))),
        ),
        title: Text(
          '${widget.userTransaction.name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
            '${DateFormat.yMMMd().format(widget.userTransaction.date)}'),
        trailing: MediaQuery.of(context).size.width > 360
            ? ElevatedButton.icon(
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
            elevation: MaterialStateProperty.all(0.0),
          ),
          onPressed: () =>
              widget.deleteTransactions(widget.userTransaction.id),
          icon: Icon(
            Icons.delete,
            // color: Theme.of(context).errorColor,
          ),
          label: Text(
            'Delete',
            style: TextStyle(
              // color: Theme.of(context).errorColor,
            ),
          ),
        )
            : IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          color: Theme.of(context).errorColor,
          onPressed: () =>
              widget.deleteTransactions(widget.userTransaction.id),
        ),
      ),
    );
  }
}
