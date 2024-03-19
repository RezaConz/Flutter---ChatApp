import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../components/button.dart';
import '../components/text_field.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final Function()? onTap;
  RegisterPage({super.key, this.onTap});

  register(BuildContext context) {
    final _auth = AuthService();
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        _auth.signUpWithEmailPassword(
            _emailController.text, _passwordController.text);
      } on Exception catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Password don't match!!"),
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
              "Create an account first :) ",
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
              height: 15,
            ),
            TextFieldPrimary(
              hint: "Confirm Password",
              secured: true,
              controller: _confirmPasswordController,
            ),
            const SizedBox(
              height: 25,
            ),
            ButtonPrimary(
              text: "Register",
              ontap: () => register(context),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login",
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
