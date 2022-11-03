import 'package:flutter/foundation.dart' show immutable;

@immutable
class LoginHandle {
  final String token;

  const LoginHandle(this.token);

  const LoginHandle.fooBar() : token = 'foobar';

  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() {
    return 'LoginHandle{token: $token}';
  }
}

enum LoginErrors { invalidLoginHandle }

@immutable
class Note {
  final String title;

  const Note({required this.title});

  @override
  String toString() {
    return 'Note{note: $title}';
  }
}

final mockNotes = Iterable.generate(
  3,
  (i) => Note(title: 'Note ${i + 1}'),
);
