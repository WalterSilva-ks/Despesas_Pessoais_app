// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transation.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList({required this.transactions, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 535,
      child: transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 20),
                const Text("Nenhuma transsação cadastrada!!!!",
                    style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Container(
                  height: 300,
                  child: Image.asset(
                    'assets/images/z.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          'R\$${tr.value}',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ),
                  ),
                  trailing: IconButton(
                      onPressed: () => onRemove(tr.id),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.black,
                      )),
                  title: Text(tr.title,
                      style: Theme.of(context).textTheme.titleMedium),
                  subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                );
              },
            ),
    );
  }
}
