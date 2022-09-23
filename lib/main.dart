import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

const names = ['nik', 'shiv', 'ravi'];

extension RandomElement<T> on Iterable<T> {
  T getRandom() => elementAt(Random().nextInt(length));
}

class NameCubit extends Cubit<String?> {
  NameCubit() : super(null);

  void provideRandom() => emit(names.getRandom());
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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NameCubit nameCubit;

  @override
  void initState() {
    super.initState();
    nameCubit = NameCubit();
  }

  @override
  void dispose() {
    nameCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: StreamBuilder<String?>(
        stream: nameCubit.stream,
        builder: (context, snapshot) {
          final button = TextButton(
              onPressed: () {
                return nameCubit.provideRandom();
              },
              child: const Text("Pick Random"));

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return button;
              break;
            case ConnectionState.waiting:
              return button;
              break;
            case ConnectionState.active:
              return Column(
                children: [Text(snapshot.data ?? ""), button],
              );
              break;
            case ConnectionState.done:
              return const SizedBox();
              break;
          }
        },
      ),
    );
  }
}
