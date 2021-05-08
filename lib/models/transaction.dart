import 'package:flutter/cupertino.dart';

class Transaction {
  final double amount;
  final DateTime date;
  final String name;

  Transaction({
    @required this.amount,
    @required this.date,
    @required this.name,
  });
}
