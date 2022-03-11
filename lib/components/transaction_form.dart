// ignore_for_file: unused_local_variable, use_key_in_widget_constructors

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit) {
    print("Construtor transaction form");
  }

  @override
  State<TransactionForm> createState() {
    print("Creat state");
    return _TransactionFormState();
  }
}

class _TransactionFormState extends State<TransactionForm> {
  String title = '';

  double value = 0;

  final titleController = TextEditingController();

  final valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _TransactionFormState() {
    print("Construtor transaction");
  }

  @override
  void initState() {
    super.initState();
    print("initState TransactionForm");
  }

  _submitForm() {
    {
      final title2 = title.toString();
      final value2 = double.tryParse(value.toString()) ?? 0.0;
      if (title.isEmpty || value2 <= 0 || _selectedDate == null) {
        return;
      }
      widget.onSubmit(title, value, _selectedDate);
    }
  }

  _showDatePicker() {
    showDatePicker(
      cancelText: 'Cancelar',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
              onChanged: (newValue) => title = newValue,
              decoration: const InputDecoration(
                label: Text('Titulo'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: valueController,
              onSubmitted: (_) => _submitForm(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (newValue) =>
                  value = double.tryParse(newValue.toString())!,
              decoration: const InputDecoration(
                label: Text('Valor( R\$)'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 70,
              child: Row(children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'Nehuma data selecionada!'
                      : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: const Text('Selecionar data',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                )
              ]),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: _submitForm,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.save, color: Colors.white),
                    Text("Salvar", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
