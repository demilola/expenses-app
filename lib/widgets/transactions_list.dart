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
    ThemeData _theme = Theme.of(context);
        MediaQueryData _mediaQuery = MediaQuery.of(context);

    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) => Column(
              children: [
                Text('No Transactions Yet', style: _theme.textTheme.headline5),
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
                              _mediaQuery.size.width * .02),
                          child: SizedBox(
                            height: _mediaQuery.size.height * 0.03,
                            child: FittedBox(
                                child: Text(
                                    '\$${transactions[index].amount.toStringAsFixed(2)}')),
                          ),
                        ),
                      ),
                      // ),
                      title: Text(transactions[index].title,
                          style: _theme.textTheme.headline6),
                      subtitle: Text(
                        DateFormat.yMMMMd().format(transactions[index].date),
                      ),
                      trailing: _mediaQuery.size.width > 400
                          ? FlatButton.icon(
                              onPressed: () =>
                                  deleteTransaction(transactions[index].id),
                              icon: Icon(Icons.delete,
                                  color: _theme.errorColor),
                              label: Text('Delete'),
                              textColor: _theme.errorColor,
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: _theme.errorColor,
                              ),
                              onPressed: () =>
                                  deleteTransaction(transactions[index].id)),
                    ),
                  ));
            });
  }
}
