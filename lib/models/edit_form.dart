import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditForm extends StatefulWidget {
  final void Function(String ID, String title, double value, DateTime time) onSubmit;
  String ID;
  EditForm(this.onSubmit, this.ID);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  TextEditingController TitleController = new TextEditingController();

  TextEditingController ValueController = new TextEditingController();
  DateTime? _selectedDate;

  _submitForm() {
    final title = TitleController.text;
    final value = double.tryParse(ValueController.text);
    if (title.isEmpty || value == null || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(widget.ID, title, value, _selectedDate!);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: TitleController,
              decoration: InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: ValueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Valor (R\$): "),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "Nenhuma data selecionada!"
                          : "Data selecionada: ${DateFormat('d/MM/y').format(_selectedDate!)}",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _showDatePicker,
                    child: Text("Selecionar data"),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: (){
                    _submitForm();
                    Navigator.pop(context);
                    },
                  child: Text(
                    "Atualizar",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
