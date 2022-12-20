import 'package:bloc_learning/bloc/bottom_bloc.dart';
import 'package:bloc_learning/bloc/top_bloc.dart';
import 'package:bloc_learning/models.dart';
import 'package:bloc_learning/views/app_bloc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
            providers: [
              BlocProvider<TopBloc>(
                create: (context) => TopBloc(waitBeforeLoading: const Duration(seconds: 2), urls: images),
              ),
              BlocProvider<BottomBloc>(
                create: (context) => BottomBloc(waitBeforeLoading: const Duration(seconds: 5), urls: images),
              )
            ],
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: const [
                AppBlocView<TopBloc>(),
                AppBlocView<BottomBloc>(),
              ],
            )),
      ),
    );
  }
}
