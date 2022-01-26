/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';

class EServiceTilWidget extends StatelessWidget {
  final Widget title;
  final Widget content;
  final List<Widget> actions;
  final double horizontalPadding;

  const EServiceTilWidget({Key key, this.title, this.content, this.actions, this.horizontalPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 10, vertical: 15),
      color: Get.theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: title),
              if (actions != null)
                Wrap(
                  children: actions,
                )
            ],
          ),
          SizedBox(
            height: 26,

          ),
          content,
        ],
      ),
    );
  }
}
