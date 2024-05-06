import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_playground/const/theme.dart';
import 'package:mvvm_playground/features/cubit/home_cubit.dart';
import 'package:mvvm_playground/features/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (_) => HomeCubit(),
        )
      ], child: MyHomePage(title: 'Messages')),
    );
  }
}
