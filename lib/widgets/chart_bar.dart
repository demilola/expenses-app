import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {Key key, this.label, this.totalAmountSpent, this.spendingPercentOfTotal})
      : super(key: key);
  final String label;
  final double totalAmountSpent;
  final double spendingPercentOfTotal;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height:MediaQuery.of(context).size.height*0.03,child: FittedBox(child: Text('\$${totalAmountSpent.toStringAsFixed(2)}'))),
        SizedBox(height: MediaQuery.of(context).size.height*0.0075),
        Container(
            height: 60,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                ),
                FractionallySizedBox(
                    heightFactor: spendingPercentOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ))
              ],
            )),
        SizedBox(height: MediaQuery.of(context).size.height*0.0075),
        SizedBox(height:MediaQuery.of(context).size.height*0.03,child:Text(label.toUpperCase()))
      ],
    );
  }
}
