import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semana4_5/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final void Function(String) onRemove;
  final void Function(BuildContext, String) onEdit;

  TransactionList(this._transactions, this.onRemove, this.onEdit);

  @override
  Widget build(context) {
    return Container(
      height: 300,
      child:
          _transactions.isEmpty
              ? Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Nehuma transação cadastrada!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
              : ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (cntx, index) {
                  final tr = _transactions[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(child: Text("R\$${tr.value}")),
                        ),
                      ),
                      title: Text(
                        tr.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(DateFormat("d MMM y").format(tr.date)),
                      trailing: Wrap(
                        spacing: 12,
                        children: [
                          IconButton(onPressed: () => onRemove(tr.id), 
                          icon: Icon(Icons.delete)),
                          IconButton(onPressed: () => onEdit(context, tr.id), icon: Icon(Icons.edit))
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
