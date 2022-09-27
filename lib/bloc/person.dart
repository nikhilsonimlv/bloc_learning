import 'package:flutter/foundation.dart' show immutable;

@immutable
class Person {
  final String name;
  final int age;

  const Person({required this.name, required this.age});

  Person.fromJson(Map<String, dynamic> json) //Example of named constructor
      : name = json["name"] as String,
        age = json["age"] as int;

  @override
  String toString() {
    return 'Person{name: $name, age: $age}';
  }
}
