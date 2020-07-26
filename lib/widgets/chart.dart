import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({Key key, this.recentTransactions}) : super(key: key);

//To pass list of transactions from main.dart
  final List<Transaction> recentTransactions;

//To generate a list of 7 items corresponding to days of the week
  List<Map<String, dynamic>> get groupedTransactionsList {
    return List.generate(7, (index) {
      double totalSum =
          0.00; // To store the value of all the transactions for that particular day

      final DateTime weekDay = DateTime.now().subtract(Duration(
          days:
              index)); // Takes the timestamp of when the transaction was madeand subtracts [index] number of days

      //a for loop iterating through transactions in the recentTransactions list
      for (Transaction transaction in recentTransactions) {
        //This block checks whether the day(and month and year) corresponds to the weekay variable created up. So that we can add the amount spent on that day into one value.
        if (transaction.date.weekday == weekDay.weekday &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          totalSum += transaction.amount;
        } //Remember, transaction.date.whatever = DateFormat.whatever().format(transaction.date)
      }
      //To return a map containing the day the transaction was made and the amount recorded
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
      //Remember, when using just DateFormat(), a DateTime object is returned, to return a String, use DateFormat().format()
    }).reversed.toList();
  }

//Remember to comment explanation of this:
  double get totalAmountSpent => groupedTransactionsList.fold(
      0.00, (previousValue, element) => element['amount'] += previousValue);

  @override
  Widget build(BuildContext context) {
    return recentTransactions.isNotEmpty
                  ? Card(
      elevation: 5,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: 
          
                  groupedTransactionsList
                      .map((recentTransaction) =>
                          Flexible(
                            fit: FlexFit.tight,
                            child: ChartBar(
                              label: recentTransaction['day'],
                              totalAmountSpent: recentTransaction['amount'],
                              spendingPercentOfTotal: totalAmountSpent == 0.00
                                  ? 0.00
                                  : recentTransaction['amount'] /
                                      totalAmountSpent,
                            ),
                          ))
                      .toList()
                  
                ),
    ): Container();
  }
}
