import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final IconData icon;
  const DrawerTile(
      {super.key,
      required this.onTap,
      required this.title,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      onTap: onTap,
      title: Text(title),
    );
  }
}
