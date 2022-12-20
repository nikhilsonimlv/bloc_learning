import 'package:async/async.dart' show StreamGroup;

extension StatWith<T> on Stream<T>{
  /*
  this :        |X----------X---------X
  Stream.Value: |X|
  merge:        |X----------X---------X
   */

  Stream<T> startWith(T value) => StreamGroup.merge([this,Stream<T>.value(value)]);
}