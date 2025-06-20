import 'package:semana4_5/components/chart.dart';
import 'package:semana4_5/components/transaction_list.dart';
import 'package:semana4_5/models/edit_form.dart';
import 'package:semana4_5/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:semana4_5/models/transaction_form.dart';
import 'dart:math';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage()
    );
  }
}

class MainPage extends StatefulWidget {

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

    
  final List<Transaction> _transactions = [
  
  ];

  List<Transaction> get _recentTransactions{
    return _transactions.where((tr){
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date){
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(), 
      title: title, 
      value: value, 
      date: date);
    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.pop(context);
  }

  _deleteTransaction(String id){
    setState(() {
      _transactions.removeWhere((tr){
        return tr.id == id;
      });
    });
  }

  _updateTransaction(String id, String title, double value, DateTime time){
    _transactions.forEach((tr){
        if(tr.id == id){
          setState(() {
            tr.date = time;
            tr.title = title;
            tr.value = value;
          });
        }
    });
  }

  _openUpdateTransaction(BuildContext context, String ID){
    showModalBottomSheet(context: context, builder: (_){
      return EditForm(_updateTransaction, ID);
    });
  }

  _opentransactionFormModal(BuildContext context) {
    showModalBottomSheet(context: context, 
    builder: (_){
      return TransactionForm(_addTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(title: Text("Despesas pessoais", style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold),), backgroundColor: Colors.deepOrangeAccent,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Chart(_recentTransactions),
              TransactionList(_transactions, _deleteTransaction, _openUpdateTransaction)
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () => _opentransactionFormModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}