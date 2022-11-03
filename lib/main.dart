import 'package:bloc_learning/apis/login_api.dart';
import 'package:bloc_learning/bloc/actions.dart';
import 'package:bloc_learning/bloc/app_bloc.dart';
import 'package:bloc_learning/bloc/app_state.dart';
import 'package:bloc_learning/dialog/generic_dialog.dart';
import 'package:bloc_learning/dialog/loading_screen.dart';
import 'package:bloc_learning/models.dart';
import 'package:bloc_learning/strings.dart';
import 'package:bloc_learning/views/iterable_list_view.dart';
import 'package:bloc_learning/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'apis/notes_api.dart';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppBloc(loginApi: LoginAPI(), notesApi: NotesAPI()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(homePage),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState) {
            //loading screen
            if (appState.isLoading) {
              LoadingScreen.instance().show(context: context, text: pleaseWait);
            } else {
              LoadingScreen.instance().hide();
            }
            //display errors
            final loginError = appState.loginErrors;
            if (loginError != null) {
              showGenericDialog<bool>(
                context: context,
                title: loginErrorDialogTitle,
                content: loginErrorDialogContent,
                optionBuilder: () => {ok: true},
              );
            }

            //if we logged in and we don't have notes, fetch them now
            if (appState.isLoading == false && appState.loginErrors == null && appState.loginHandle == const LoginHandle.fooBar() && appState.fetchedNotes == null) {
              context.read<AppBloc>().add(const LoadingNoteAction());
            }
          },
          builder: (context, appState) {
            final notes = appState.fetchedNotes;
            if (notes == null) {
              return LoginView(
                onLoginTapped: (email, password) {
                  context.read<AppBloc>().add(LoginAction(email: email, password: password));
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
