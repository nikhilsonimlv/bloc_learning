import 'package:flutter/material.dart';

import '../strings.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailTextField({Key? key,required this.emailController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      decoration: const InputDecoration(
        hintText:enterYourEmailHere,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      keyboardAppearance: Brightness.dark,
    );
  }
}
