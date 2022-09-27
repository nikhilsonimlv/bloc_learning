import 'package:bloc_learning/bloc/bloc_actions.dart';
import 'package:bloc_learning/bloc/person.dart';
import 'package:bloc_learning/bloc/person_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import "package:test/test.dart";

const mockedPerson1 = [
  Person(name: 'Foo', age: 20),
  Person(name: 'Mia', age: 25),
];
const mockedPerson2 = [
  Person(name: 'Foo', age: 20),
  Person(name: 'Mia', age: 25),
];

Future<Iterable<Person>> getMockedPerson1(String _) => Future.value(mockedPerson1);

Future<Iterable<Person>> getMockedPerson2(String _) => Future.value(mockedPerson2);

void main() {
  group("Testing bloc", () {
    late PersonBloc personBloc;
    //This function will be called before each test is run. callback may be asynchronous; if so, it must
    setUp(() {
      personBloc = PersonBloc();
    });

    blocTest<PersonBloc, FetchResult?>(
      "Test initial state",
      build: () => personBloc,
      verify: (personBloc) => expect(personBloc.state, null),
    );

    blocTest<PersonBloc, FetchResult?>("Mock retrieving persons from first iterable",
        build: () => personBloc,
        act: (personBloc) {
          personBloc.add(const LoadPersonAction(
            url: "Dummy url 1",
            personLoader: getMockedPerson1,
          ));
          personBloc.add(const LoadPersonAction(
            url: "Dummy url 1",
            personLoader: getMockedPerson1,
          ));
        },
        expect: () => [
              const FetchResult(
                persons: mockedPerson1,
                isRetrievedFromCache: false,
              ),
              const FetchResult(
                persons: mockedPerson1,
                isRetrievedFromCache: true,
              )
            ]);

    blocTest<PersonBloc, FetchResult?>("Mock retrieving persons from Second iterable",
        build: () => personBloc,
        act: (personBloc) {
          personBloc.add(const LoadPersonAction(
            url: "Dummy url 2",
            personLoader: getMockedPerson1,
          ));
          personBloc.add(const LoadPersonAction(
            url: "Dummy url 2",
            personLoader: getMockedPerson1,
          ));
        },
        expect: () => [
              const FetchResult(
                persons: mockedPerson2,
                isRetrievedFromCache: false,
              ),
              const FetchResult(
                persons: mockedPerson2,
                isRetrievedFromCache: true,
              )
            ]);
  });
}
