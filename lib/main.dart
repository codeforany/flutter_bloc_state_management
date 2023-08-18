import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_state_management/bloc/items_bloc.dart';
import 'package:flutter_bloc_state_management/cubit/user_cubit.dart';
import 'package:flutter_bloc_state_management/my_bloc_observer.dart';
import 'package:flutter_bloc_state_management/repo/items_repo.dart';
import 'package:flutter_bloc_state_management/repo/user_repo.dart';

import 'view/home/home_view.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(
        create: (context) => ItemsRepo(),
      ),
      RepositoryProvider(
        create: (context) => UserRepo(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ItemsBloc(ItemsRepo()),
        ),
        BlocProvider(
          create: (context) => UserCubit(UserRepo()),
        ),
      ],
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
