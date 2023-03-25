// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'utils/hive_helper.dart';
import 'view/home/home_view.dart';
import 'utils/theme.dart';

import 'utils/bloc_observer.dart';
import 'utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await HiveHelper.init();
  BlocOverrides.runZoned(
    () async => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.isDark}) : super(key: key);
  final bool? isDark;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //TODO: add your application name here
      title: '',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateRoute: onGenerateRoute,
      themeMode: ThemeMode.light,
      theme: lightTheme(context),
      home: const HomeView(),
    );
  }
}
