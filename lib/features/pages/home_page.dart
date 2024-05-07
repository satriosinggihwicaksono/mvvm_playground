import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm_playground/features/models/home_model.dart';
import 'package:mvvm_playground/widgets/input.dart';
import 'package:mvvm_playground/widgets/list_items.dart';
import 'package:mvvm_playground/widgets/navigation_bar.dart';
import 'package:mvvm_playground/widgets/page_template.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String json = '';
  List<Data> list = [];
  @override
  void initState() {
    super.initState();
    getData(json);
  }

  Future<dynamic> getData(String str) async {
    str = await DefaultAssetBundle.of(context)
        .loadString("assets/json/list_chat.json");
    final json = jsonDecode(str);
    list =
        (json['data'] as List<dynamic>).map((e) => Data.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: 'Messages'),
        body: ScrollPage(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: textField(placeholder: 'Search'),
            ),
            Column(
              children: List.generate(list.length, (index) {
                return listItem(
                    onTap: () {}, child: itemChat(data: list[index]));
              }),
            ),
          ],
        )));
  }
}
