import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_state_management/bloc/items_bloc.dart';
import 'package:flutter_bloc_state_management/my_bloc_observer.dart';
import 'package:flutter_bloc_state_management/repo/items_repo.dart';

import 'view/home/home_view.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(RepositoryProvider(
    create: (context) => ItemsRepo(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemsBloc(ItemsRepo()),
      child: MaterialApp(
        title: 'Flutter Bloc State Management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
