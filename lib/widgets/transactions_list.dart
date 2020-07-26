import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionsList(
    this.transactions,
    this.deleteTransaction,
  );

  // final Function removeTransaction;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) => Column(
              children: [
                Text('No Transactions Yet', style: theme.textTheme.headline5),
                SizedBox(height: constraints.maxHeight * .005),
                Expanded(
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text('Transaction Tapped'),
                          actions: [
                            FlatButton(
                              child: Text('Close'),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ),
                      ),
                  // onLongPress: removeTransaction(index),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * .02),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                            child: FittedBox(
                                child: Text(
                                    '\$${transactions[index].amount.toStringAsFixed(2)}')),
                          ),
                        ),
                      ),
                      // ),
                      title: Text(transactions[index].title,
                          style: theme.textTheme.headline6),
                      subtitle: Text(
                        DateFormat.yMMMMd().format(transactions[index].date),
                      ),
                      trailing: MediaQuery.of(context).size.width > 400
                          ? FlatButton.icon(
                              onPressed: () =>
                                  deleteTransaction(transactions[index].id),
                              icon: Icon(Icons.delete,
                                  color: Theme.of(context).errorColor),
                              label: Text('Delete'),
                              textColor: Theme.of(context).errorColor,
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).errorColor,
                              ),
                              onPressed: () =>
                                  deleteTransaction(transactions[index].id)),
                    ),
                  ));
            });
  }
}
