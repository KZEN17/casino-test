import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/injection/main_di_module.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:casino_test/src/presentation/pages/character_screen.dart';
import 'package:casino_test/src/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainDIModule().configure(GetIt.I);
    return BlocProvider(
      create: (context) => MainPageBloc(
        InitialMainPageState(),
        GetIt.I.get<CharactersRepository>(),
      ),
      child: MaterialApp(
        title: 'Test app',
        home: SplashScreen(),
      ),
    );
  }
}
