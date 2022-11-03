import 'package:bloc_learning/dialog/generic_dialog.dart';
import 'package:flutter/material.dart';

import '../strings.dart';

typedef OnLoginTapped = Function(String email, String password);

class LoginButton extends StatelessWidget {
  final OnLoginTapped onLoginTapped;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({Key? key, required this.onLoginTapped, required this.emailController, required this.passwordController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          final email = emailController.text;
          final password = passwordController.text;
          if (email.isEmpty || password.isEmpty) {
            showGenericDialog<bool>(
              context: context,
              title: emailOrPasswordEmptyDialogTitle,
              content: emailOrPasswordEmptyDescription,
              optionBuilder: () => {ok: true},
            );
          }else{
            onLoginTapped(email,password);
          }
        },
        child: const Text(login));
  }
}
