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
