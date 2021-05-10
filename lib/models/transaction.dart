import 'package:flutter/material.dart';

class Transaction {
  final double amount;
  final DateTime date;
  final String name;
  final String id;

  Transaction({
    @required this.amount,
    @required this.date,
    @required this.name,
    @required this.id
  });
}
