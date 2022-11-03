import 'package:flutter/foundation.dart' show immutable;

import '../models.dart';

@immutable
abstract class LoginAPIProtocol {
  const LoginAPIProtocol();

  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

@immutable
class LoginAPI implements LoginAPIProtocol {
/*  //Singleton Pattern
  const LoginAPI._sharedInstance(); // this is a private constructor
  static const LoginAPI _shared = LoginAPI._sharedInstance();

  factory LoginAPI.instance() => _shared; // this is a public constructor*/
  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) {
    return Future.delayed(const Duration(seconds: 2), () => email == 'foo@bar.com' && password == 'foo').then(
      (isLoggedIn) => isLoggedIn ? const LoginHandle.fooBar() : null,
    );
  }
}
