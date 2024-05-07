import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_playground/const/theme.dart';
import 'package:mvvm_playground/features/models/home_model.dart';

Widget listItem({
  required Widget child,
  void Function()? onTap,
}) {
  return Column(
    children: [
      InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          )),
      Container(
        decoration: const ShapeDecoration(
          shape: Border(bottom: BorderSide(color: borderColor, width: 0.5)),
        ),
      )
    ],
  );
}

Widget itemChat({required Data data}) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(data.imageUrl),
          maxRadius: 30,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.displayName,
                    style: textHeading2Alt,
                  ),
                  Text(data.lastSent, style: subtitle2)
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                data.lastMessage,
                style: subtitle,
              )
            ],
          ),
        )
      ],
    ),
  );
}
