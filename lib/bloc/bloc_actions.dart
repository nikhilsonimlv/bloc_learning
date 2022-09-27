import 'package:bloc_learning/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;

const person1Url = "http://127.0.0.1:5500/api/person1.json";
const person2Url = "http://127.0.0.1:5500/api/person2.json";

typedef PersonLoader = Future<Iterable<Person>> Function(String url);


@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
//This is the input to the bloc
class LoadPersonAction extends LoadAction {
  final String url;
  final PersonLoader personLoader;

  //Whenever we dispatch a action to bloc it requires a url with it to complete that process.So we will add a url to its constructor
  const LoadPersonAction({required this.url, required this.personLoader}) : super();
}
