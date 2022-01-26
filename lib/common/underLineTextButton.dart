import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:home_services/common/colors.dart';

class UnderLineTextButton extends StatelessWidget {
  String text;
  Function onPressed;

  UnderLineTextButton({@required this.text,@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text.tr, style: Get.textTheme.subtitle1.copyWith(color: defColor,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline)),
    );
  }
}
