import 'package:bloc_learning/models.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class NotesAPIProtocol {
  const NotesAPIProtocol();

  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle});
}

class NotesAPI implements NotesAPIProtocol {

  @override
  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle}) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => loginHandle == const LoginHandle.fooBar() ? mockNotes : null,
    );
  }
}
