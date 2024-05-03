import 'package:flutter/material.dart';
import 'package:mvvm_playground/widgets/buttons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.title),
              const SizedBox(
                height: 12,
              ),
              primaryButton(
                title: 'Submit',
                onPressed: () {
                  print('s');
                },
              )
            ],
          ),
        ));
  }
}
