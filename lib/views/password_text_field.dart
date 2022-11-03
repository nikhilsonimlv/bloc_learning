import 'package:flutter/material.dart';

import '../strings.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordTextField({Key? key,required this.passwordController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      decoration: const InputDecoration(
        hintText:enterYourPasswordHere,
      ),
      autocorrect: false,
      keyboardAppearance: Brightness.dark,
      obscureText: true,
      obscuringCharacter: '◉',
    );
  }
}
