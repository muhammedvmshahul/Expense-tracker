import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTil extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final void Function(BuildContext)? deleteTapped;

  const ExpenseTil(
      {super.key,
        required this.name,
        required this.amount,
        required this.dateTime, this.deleteTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            backgroundColor: Colors.green.shade100,
            onPressed: deleteTapped,icon: Icons.delete,)
        ]),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10)
          ),
          child: ListTile(
            title: Text(name),
            subtitle: Text('${dateTime.day}/${dateTime.month}/${dateTime.year}'),
            trailing: Text('\$ $amount'),
          ),
        ),
      ),
    );
  }
}
