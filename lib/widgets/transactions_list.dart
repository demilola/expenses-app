import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import './transaction_item.dart';

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
              return TransactionItem(
                deleteTransaction: deleteTransaction,
                transaction: transactions[index],
              );
            });
  }
}
