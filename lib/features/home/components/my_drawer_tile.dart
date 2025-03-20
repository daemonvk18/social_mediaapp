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
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: onTap,
      title: Text(title),
    );
  }
}
