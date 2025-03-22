import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BioTextBox extends StatelessWidget {
  final String text;
  const BioTextBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)),
      width: double.infinity,
      child: Text(
        text.isNotEmpty ? text : 'Empty bio....',
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }
}
