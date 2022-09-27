import 'package:bloc_learning/bloc/bloc_actions.dart';
import 'package:bloc_learning/bloc/person.dart';
import 'package:bloc_learning/main.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

extension IsEqualToIgnoringOrder<T> on Iterable<T> {
  bool isEqualToIgnoringOrder(Iterable<T> other) => length == other.length && {...this}.intersection({...other}).length == length;
}

@immutable
//This is the result of the bloc (output of the bloc)
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;

  const FetchResult({required this.persons, required this.isRetrievedFromCache});

  @override
  String toString() {
    return "FetchResult (is retrieved from cache= $isRetrievedFromCache) \n Persons value is $persons";
  }

  @override
  bool operator ==(covariant FetchResult other) => persons.isEqualToIgnoringOrder(other.persons) && isRetrievedFromCache == other.isRetrievedFromCache;

  @override
  int get hashCode => Object.hash(persons, isRetrievedFromCache);
}

///Bloc Class
class PersonBloc extends Bloc<LoadPersonAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};

  PersonBloc() : super(null) {
    on<LoadPersonAction>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        final cachedPersons = _cache[url]!;
        final result = FetchResult(persons: cachedPersons, isRetrievedFromCache: true);
        emit(result);
      } else {
        final loader = event.personLoader;
        final persons = await loader(url);
        _cache[url] = persons;
        final result = FetchResult(persons: persons, isRetrievedFromCache: false);
        emit(result);
      }
    });
  }
}
