import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextFieldPrimary extends StatelessWidget {
  final String hint;
  final bool secured;
  final TextEditingController controller;
  const TextFieldPrimary(
      {super.key, required this.hint, required this.secured, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary,
          hintText: hint,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        obscureText: secured,
        controller: controller,
      ),
    );
  }
}
