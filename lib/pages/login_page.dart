import 'dart:math';

import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Function()? onTap;

  LoginPage({super.key, this.onTap});

  login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 50,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Welcome Back",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFieldPrimary(
              hint: "Email",
              secured: false,
              controller: _emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldPrimary(
              hint: "Password",
              secured: true,
              controller: _passwordController,
            ),
            const SizedBox(
              height: 25,
            ),
            ButtonPrimary(
              text: "Login",
              ontap: () => login(context),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Register",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
