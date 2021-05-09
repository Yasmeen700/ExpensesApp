import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double totalDayAmount;
  final double percentOfTotal;

  ChartBar(this.day, this.percentOfTotal, this.totalDayAmount);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(height: 20,child: FittedBox(child: Text('\$${totalDayAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 60,
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
            height: 4,
          ),
          Text(day,),
        ],
      ),
    );
  }
}