import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class UserTile extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        padding: EdgeInsets.all(25),
        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(
              width: 20,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
