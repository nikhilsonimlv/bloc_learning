import 'package:bloc_learning/models.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppState {
  final bool isLoading;
  final Uint8List? data;
  final Object? error;

  const AppState({
    required this.isLoading,
    required this.data,
    required this.error,
  });

  //default app state

  const AppState.empty()
      : isLoading = false,
        data = null,
        error = null;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, data: $data, error: $error}';
  }
}
