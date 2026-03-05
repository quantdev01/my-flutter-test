import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_test/countries/bloc/action_load.dart';
import 'package:my_flutter_test/home/home_config.dart';
import 'package:my_flutter_test/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountryBloc(),
      child: MaterialApp(
        title: 'Country Discovery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          colorSchemeSeed: Colors.white,
          scaffoldBackgroundColor: AppColors.primary,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          colorSchemeSeed: Colors.black,
          scaffoldBackgroundColor: AppColors.primaryDark,
        ),
        themeMode: ThemeMode.system,
        home: const HomeConfig(),
      ),
    );
  }
}
