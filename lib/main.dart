import 'src/shared/util/q_export.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(),
      ),
      BlocProvider(
        create: (context) => ThemeCubit(prefs: prefs),
      )
    ],
    child: const MyApp(),
  ));
}
