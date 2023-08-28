// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;

  final void Function(BuildContext)? deleteTapped;

  const ExpenseTile({
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(4),
          ),
          SlidableAction(
            onPressed: (context) => {},
            icon: Icons.edit,
            backgroundColor: Colors.green,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text('${dateTime.year}/${dateTime.month}/${dateTime.day}'),
        trailing: Text('\$${amount}'),
      ),
    );
  }
}
