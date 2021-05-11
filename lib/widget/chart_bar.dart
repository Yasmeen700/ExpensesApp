import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double totalDayAmount;
  final double percentOfTotal;

  ChartBar(this.day, this.percentOfTotal, this.totalDayAmount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${totalDayAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight*0.15,
            child: FittedBox(
              child: Text(
                day,
              ),
            ),
          ),
        ],
      );
    });
  }
}
