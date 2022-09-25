import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => PersonBloc(),
        child: const HomePage(),
      ),
    );
  }
}

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
//This is the input to the bloc
class LoadPersonAction extends LoadAction {
  final PersonUrls url;

  //Whenever we dispatch a action to bloc it requires a url with it to complete that process.So we will add a url to its constructor
  const LoadPersonAction({required this.url}) : super();
}

enum PersonUrls { person1, person2 }

extension Log on Object {
  void log() => devtools.log(toString());
}

extension UrlString on PersonUrls {
  String get urlString {
    switch (this) {
      case PersonUrls.person1:
        return "http://127.0.0.1:5500/api/person1.json";

      case PersonUrls.person2:
        return "http://127.0.0.1:5500/api/person2.json";
    }
  }
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

@immutable
class Person {
  final String name;
  final int age;

  const Person.name({required this.name, required this.age});

  Person.fromJson(Map<String, dynamic> json) //Example of named constructor
      : name = json["name"] as String,
        age = json["age"] as int;

  @override
  String toString() {
    return 'Person{name: $name, age: $age}';
  }
}

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((request) => request.close())
    .then((response) => response.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));

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
}

///Bloc Class
class PersonBloc extends Bloc<LoadPersonAction, FetchResult?> {
  final Map<PersonUrls, Iterable<Person>> _cache = {};

  PersonBloc() : super(null) {
    on<LoadPersonAction>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        final cachedPersons = _cache[url]!;
        final result = FetchResult(persons: cachedPersons, isRetrievedFromCache: true);
        emit(result);
      } else {
        final persons = await getPersons(event.url.urlString);
        _cache[url] = persons;
        final result = FetchResult(persons: persons, isRetrievedFromCache: false);
        emit(result);
      }
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.read<PersonBloc>().add(const LoadPersonAction(url: PersonUrls.person1));
                },
                child: const Text("Load Json # 1"),
              ),
              TextButton(
                onPressed: () {
                  context.read<PersonBloc>().add(const LoadPersonAction(url: PersonUrls.person2));
                },
                child: const Text("Load Json # 2"),
              ),
            ],
          ),
          BlocBuilder<PersonBloc, FetchResult?>(
            builder: (context, fetchResult) {
              fetchResult?.log();
              final persons = fetchResult?.persons;
              if (persons == null) {
                return const SizedBox();
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: persons.length,
                  itemBuilder: (context, index) {
                    final person = persons[index]!; // Here it is using our Subscript extension we created above
                    return ListTile(
                      title: Text(person.name),
                    );
                  },
                ),
              );
            },
            buildWhen: (previousResult, currentResult) {
              return previousResult?.persons != currentResult?.persons;
            },
          )
        ],
      ),
    );
  }
}
