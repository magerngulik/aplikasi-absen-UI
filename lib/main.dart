import 'package:dio/dio.dart';
import 'package:new_attandance/src/presentation/home/bloc/location/location_cubit.dart';
import 'package:new_attandance/src/presentation/home/bloc/user_status/user_status_cubit.dart';
import 'package:new_attandance/src/shared/function/q_function.dart';

import 'src/shared/util/q_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  getPermision();
  Dio dio = Dio();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(),
      ),
      BlocProvider(
        create: (context) => ThemeCubit(prefs: prefs),
      ),
      BlocProvider(
        create: (context) => LocationCubit(dio),
      ),
      BlocProvider(
        create: (context) => UserStatusCubit(dio: dio),
      )
    ],
    child: const MyApp(),
  ));
}
