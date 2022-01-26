import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services/common/icon_broken.dart';

import '../home/controllers/home_controller.dart';

class SearchBarWidget extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          border: Border.all(
            color: Get.theme.focusColor.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 0),
            child: Icon(IconBroken.Search, color: Get.theme.colorScheme.onBackground),
          ),
          Expanded(
            child: Text(
              "Search for handyman...".tr,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: Get.textTheme.caption,
            ),
          ),
          SizedBox(width: 8),

        ],
      ),
    );
  }
}
