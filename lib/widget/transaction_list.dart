import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        : ListView.builder(
            itemCount: userTransactions.length,
            itemBuilder: (BuildContext ctx, int index) {
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
                                Text('\$${userTransactions[index].amount}'))),
                  ),
                  title: Text(
                    '${userTransactions[index].name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                      '${DateFormat.yMMMd().format(userTransactions[index].date)}'),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? ElevatedButton.icon(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                      elevation: MaterialStateProperty.all(0.0),
                    ),
                          onPressed: () =>
                              deleteTransactions(userTransactions[index].id),
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
                              deleteTransactions(userTransactions[index].id),
                        ),
                ),
              );
            },
          );
  }
}
