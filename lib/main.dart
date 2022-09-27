import 'dart:convert';
import 'dart:developer' as devtools show log;
import 'dart:io';

import 'package:bloc_learning/bloc/bloc_actions.dart';
import 'package:bloc_learning/bloc/person.dart';
import 'package:bloc_learning/bloc/person_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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


extension Log on Object {
  void log() => devtools.log(toString());
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}



Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((request) => request.close())
    .then((response) => response.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));




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
                  context.read<PersonBloc>().add(const LoadPersonAction(url: person1Url,personLoader: getPersons));
                },
                child: const Text("Load Json # 1"),
              ),
              TextButton(
                onPressed: () {
                  context.read<PersonBloc>().add(const LoadPersonAction(url: person2Url,personLoader: getPersons));
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
