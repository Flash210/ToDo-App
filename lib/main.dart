import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ret_training/busnisses_logic/cubit/my_cubit.dart';
import 'package:ret_training/injection.dart';
import 'package:ret_training/screens/HomeScreen/home_screen.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo List App',
      home: BlocProvider(
        create: (context) => getIt<MyCubit>(),
        child: const HomeScreen()),
    );
  }
}