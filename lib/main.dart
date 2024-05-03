import 'package:flutter/cupertino.dart';
import 'package:mvvm_playground/const/theme.dart';
import 'package:mvvm_playground/features/main/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Flutter Demo',
      theme: mainTheme,
      home: MyHomePage(title: 'Flutter Demo Page'),
    );
  }
}
