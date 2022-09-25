# bloc_learning

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Step 1 Simple cubit example:-
1. Bloc and flutter bloc both are different packages, bloc is the primary thing of bloc library it contains the building blocks like cubit, blocs etc however flutter_bloc is require when we want our UI elements need to interact with bloc using stream, stream controller etc.
2. Cubit is one level higher from stream and stream controller, so they can allow us to avoid dirty methods of stream and stream controller
3. Both cubit and bloc should have some initial state.
4. emit() is a way by which bloc or cubit can produce new state.
5. Whenever we create a cubit we should also dispose it.
6. Cubit is just like a streams and stream controller.

Step 2 Simple Bloc example :-
Bloc :-
1. bloc works with actions and results.
2. Blocs are the classes that extends Bloc.
3. Action is just like an input to a bloc to perform an action.
4. A bloc can accept more than one type of “event or action” and it can also produce more than one type of state. Because of this we should create a “abstract class” for actions, so that we can say that bloc accepts this single complete class of actions
5. Bloc provider injects a specific bloc into its build context so that its children can access it.
6. read() function traverse all the way up to the widget hierarchy and extract the bloc presents in that build context. For eg :- context.read<TestBloc>();  with this we use add() to send an action or command to bloc For eg :- context.read<TestBloc>().add(<-Action name->);
7. BlocBuilder  is use to listen the changes happening in the bloc and update the dependent children.
