import '../models/transaction.dart';
import 'package:flutter/material.dart';

import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransactions;

  TransactionList(this.userTransactions, this.deleteTransactions);

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'No transactions added yet!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView(
            children: userTransactions
                .map(
                  (e) => TransactionItem(
                    key:ValueKey(e.id) ,
                    userTransaction: e,
                    deleteTransactions: deleteTransactions,
                  ),
                )
                .toList(),
          );
  }
}
