import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionsList(
    this.transactions, this.deleteTransaction,
  );

  // final Function removeTransaction;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return
        // Container(
        //   height: MediaQuery.of(context).size.height * 5.8 / 10,
        // child:
        transactions.isEmpty
            ? Column(
                children: [
                  Text('No Transactions Yet', style: theme.textTheme.headline5),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 1.0 / 100.0),
                  Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover, height: 250.0)
                ],
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
                              child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}',
                              )),
                          // ),
                          title: Text(transactions[index].title,
                              style: theme.textTheme.headline6),
                          subtitle: Text(
                            DateFormat.yMMMMd()
                                .format(transactions[index].date),
                          ),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                              ),
                              onPressed: ()=> deleteTransaction(transactions[index].id)),
                    ),
                  ));
                });
  }
}
