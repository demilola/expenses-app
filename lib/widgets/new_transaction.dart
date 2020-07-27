import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate;
  void submitData() {
    final String inputTitle = _titleController.text;
    final double inputAmount = double.parse(_amountController.text);
    final DateTime date = _selectedDate;

    if (inputTitle.isNotEmpty && inputAmount >= 0 && date != null) {
      widget.addTransaction(inputTitle, inputAmount, date);
      // _focusScopeNode.nextFocus();
      Navigator.pop(
          context); //We dnt have any p with context because this is a state class not widget class
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('No Info Passed'),
      ));
    }
  }

  void _presentDatePicker() => CupertinoDatePicker(
        onDateTimeChanged: (value) => _selectedDate = value,
      );
  // context: context,
  // initialDate: DateTime.now(),
  // firstDate: DateTime.now().subtract(Duration(days: 28)),
  // lastDate: DateTime.now())
  // .then((value) => _selectedDate = value);

  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // String date = DateFormat.yMEd().format(_selectedDate);
    MediaQueryData _mediaQuery = MediaQuery.of(context);

    return Container(
      color: const Color(0xff757575),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: SingleChildScrollView(
            padding: _mediaQuery.viewInsets,
            child: FocusScope(
              node: _focusScopeNode,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: _mediaQuery.size.height * 1 / 100),
                  Text(
                    'Add New Transaction',
                    style: theme.textTheme.headline5
                        .copyWith(color: Colors.purple[700]),
                  ),
                  SizedBox(height: _mediaQuery.size.height * 1 / 100),
                  SizedBox(),
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Title',
                      hintText: 'Enter Title Here',
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => _focusScopeNode.nextFocus(),
                    onSubmitted: (_) =>
                        submitData(), // Here, I changed it from a simple fn reference (submitData) to a newTransaction (submitData()), so that, when we tap submit, it actually runs
                    onChanged: (value) => _titleController.text = value,
                  ),
                  SizedBox(height: _mediaQuery.size.height * 1 / 100),
                  TextField(
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        labelText: 'Amount'),
                    onSubmitted: (_) => submitData(),
                    textInputAction: TextInputAction.done,
                    onEditingComplete: _selectedDate == null
                        ? _presentDatePicker
                        : () => _focusScopeNode.nextFocus(),
                    // _focusScopeNode.nextFocus(),
                    onChanged: (value) => _amountController.text = value,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_selectedDate == null
                          ? 'No Date Selected'
                          : 'Picked Date: ${DateFormat.yMEd().format(_selectedDate)}'),
                      Platform.isIOS
                          ? CupertinoButton(
                              onPressed: _presentDatePicker,
                              child: Text(
                                  _selectedDate == null
                                      ? 'Choose Date'
                                      : 'Change Date',
                                  style: TextStyle(color: theme.primaryColor)))
                          : FlatButton(
                              onPressed: _presentDatePicker,
                              child: Text(
                                  _selectedDate == null
                                      ? 'Choose Date'
                                      : 'Change Date',
                                  style: TextStyle(color: theme.primaryColor))),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Platform.isIOS
                        ? CupertinoButton(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                            child: const Text(
                              'Add Transaction',
                              // style: TextStyle(color: Colors.purple),
                            ),
                            onPressed: submitData,
                          )
                        : RaisedButton(
                            color: theme.primaryColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              'Add Transaction',
                              // style: TextStyle(color: Colors.purple),
                            ),
                            onPressed: submitData,
                          ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
