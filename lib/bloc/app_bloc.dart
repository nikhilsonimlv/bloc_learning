import 'package:bloc/bloc.dart';
import 'package:bloc_learning/apis/login_api.dart';
import 'package:bloc_learning/apis/notes_api.dart';
import 'package:bloc_learning/bloc/actions.dart';
import 'package:bloc_learning/bloc/app_state.dart';
import 'package:bloc_learning/models.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginAPIProtocol loginApi;
  final NotesAPIProtocol notesApi;

  AppBloc({required this.loginApi, required this.notesApi}) : super(const AppState.empty()) {
    on<LoginAction>(
      ((event, emit) async {
        //start Loading
        emit(const AppState(
          isLoading: true,
          loginErrors: null,
          loginHandle: null,
          fetchedNotes: null,
        ));
        //Log the user
        final loginHandle = await loginApi.login(email: event.email, password: event.password);
        emit(
          AppState(
            isLoading: false,
            loginErrors: loginHandle == null ? LoginErrors.invalidLoginHandle : null,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
      }),
    );

    on<LoadingNoteAction>(
      (event, emit) async {
        //start Loading
        emit(
          AppState(
            isLoading: true,
            loginErrors: null,
            loginHandle: state.loginHandle,
            fetchedNotes: null,
          ),
        );

        final loginHandle = state.loginHandle;
        if (loginHandle != const LoginHandle.fooBar()) {
          //start Loading
          emit(
            AppState(
              isLoading: false,
              loginErrors: LoginErrors.invalidLoginHandle,
              loginHandle: loginHandle,
              fetchedNotes: null,
            ),
          );
          return;
        }
        final fetchedNotes = await notesApi.getNotes(loginHandle: loginHandle!);
        emit(
          AppState(
            isLoading: false,
            loginErrors: null,
            loginHandle: loginHandle,
            fetchedNotes: fetchedNotes,
          ),
        );
      },
    );
  }
}
