import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;
  ExpenseTile(
      {super.key,
      required this.name,
      required this.amount,
      required this.dateTime,
      required this.deleteTapped});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: BehindMotion(), children: [
        SlidableAction(
          backgroundColor: Colors.redAccent.shade700,
          onPressed: deleteTapped,
          icon: Icons.delete,
          borderRadius: BorderRadius.circular(10),
        )
      ]),
      child: ListTile(
        title: Text('Item= $name'),
        trailing: Text('Price= $amount'),
        subtitle: Text('Time of Purchase= '
            '${dateTime.year}/${dateTime.month}/${dateTime.day}'),
      ),
    );
  }
}
