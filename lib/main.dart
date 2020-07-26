import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: GoogleFonts.openSansTextTheme()
            .apply(fontSizeFactor: MediaQuery.textScaleFactorOf(context)),
        accentTextTheme: GoogleFonts.quicksandTextTheme()
            .apply(fontSizeFactor: MediaQuery.textScaleFactorOf(context)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0.0,
        ),
        typography: Typography.material2018(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '💰 Expenses App 💰'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: 'tx1',
    //   title: 'Transaction1',
    //   amount: 45.55,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'tx2',
    //   title: 'Transaction2',
    //   amount: 65.45,
    //   date: DateTime.now().subtract(Duration(days: 1)),
    // ),
    // Transaction(
    //   id: 'tx3',
    //   title: 'Transaction3',
    //   amount: 84.96,
    //   date: DateTime.now().subtract(Duration(days: 2)),
    // ),
  ]
      // .reversed.toList()
      ; // implement logic hee to make sure the last index comes first

  List<Transaction> get recentTransactions {
    //METHOD 1: This method creates a new List, then uses a for loop then an if statement to populate a new List
    // List<Transaction> newList;
    // for (Transaction transaction in _transactions) {
    //   if (transaction.date == DateTime.now().subtract(Duration(days: 7))) {
    //     newList.add(transaction);
    //   }
    // }
    // return newList;
    // METHOD 2: this method uses the built in [where] method that checks whether a conditional is true and if yes, returns a list including that particular iterable
    return _transactions
        .where((transaction) =>
            // transaction.date == DateTime.now().subtract(Duration(days: 7)));//This is quite primitive as you are checking the time kind of manually, So instead, use the built in isAfter method
            transaction.date.isAfter(
              DateTime.now().subtract(
                Duration(days: 7),
              ),
            ))
        .toList(); //We have to call toList() because where returns an iterable and not a List as required
  }

  void _addTransaction(String title, double amount, DateTime date) {
    final _newTransaction = Transaction(
        title: title,
        amount: amount,
        date: date,
        id: DateTime.now().toString());
    setState(() => _transactions.add(_newTransaction));
  }

  void _deleteTransaction(String id) {
    setState(() => _transactions.removeWhere((element) => element.id == id));
  }

  void _openModalSheet(BuildContext context) => showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => NewTransaction(_addTransaction));

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text(widget.title),
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              //Here, we are calculating the amount of view space left by subtracting the height of the app bar (which we made into a variable to access), and the padding at the top which is usually the status bar
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  .25,
              child: Chart(
                recentTransactions: recentTransactions,
              )),
          Expanded(child: TransactionsList(_transactions, _deleteTransaction))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor:
            Theme.of(context).floatingActionButtonTheme.foregroundColor,
        onPressed: () => _openModalSheet(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
