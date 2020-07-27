import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.deleteTransaction,
    @required this.transaction,
  }) : super(key: key);

  final Function deleteTransaction;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final MediaQueryData _mediaQuery = MediaQuery.of(context);

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
        onLongPress: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text('Are you sure you want to delete this Task?'),
                  actions: [
                    FlatButton(
                        child: Text('No'),
                        onPressed: () => Navigator.pop(context)),
                    RaisedButton(
                        color: _theme.errorColor,
                        child: Text('Yes'),
                        onPressed: () {
                          deleteTransaction(transaction.id);
                          Navigator.pop(context);
                        })
                  ],
                )),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(_mediaQuery.size.width * .02),
                child: SizedBox(
                  height: _mediaQuery.size.height * 0.03,
                  child: FittedBox(
                      child:
                          Text('\$${transaction.amount.toStringAsFixed(2)}')),
                ),
              ),
            ),
            // ),
            title: Text(transaction.title, style: _theme.textTheme.headline6),
            subtitle: Text(
              DateFormat.yMMMMd().format(transaction.date),
            ),
            trailing: _mediaQuery.size.width > 400
                ? FlatButton.icon(
                    onPressed: () => deleteTransaction(transaction.id),
                    icon: Icon(Icons.delete, color: _theme.errorColor),
                    label: Text('Delete'),
                    textColor: _theme.errorColor,
                  )
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: _theme.errorColor,
                    ),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text(
                                  'Are you sure you want to delete this Task?'),
                              actions: [
                                FlatButton(
                                    child: Text('No'),
                                    onPressed: () => Navigator.pop(context)),
                                RaisedButton(
                                    color: _theme.errorColor,
                                    child: Text('Yes'),
                                    onPressed: () {
                                      deleteTransaction(transaction.id);
                                      Navigator.pop(context);
                                    })
                              ],
                            ))),
          ),
        ));
  }
}
