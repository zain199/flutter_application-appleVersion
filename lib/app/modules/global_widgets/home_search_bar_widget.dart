import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services/common/icon_broken.dart';

import '../../routes/app_routes.dart';
import '../search/controllers/search_controller.dart';
import 'filter_bottom_sheet_widget.dart';

class HomeSearchBarWidget extends StatelessWidget implements PreferredSize {
  final controller = Get.find<SearchController>();

  Widget buildSearchBar() {
    controller.heroTag.value = UniqueKey().toString();
    return Hero(
      tag: controller.heroTag.value,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: Container(
                //margin: EdgeInsets.only(left: 20, right: 20, bottom: 16),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    border: Border.all(
                      color: Get.theme.focusColor.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.SEARCH, arguments: controller.heroTag.value);
                  },
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 12, left: 0),
                        child: Icon(IconBroken.Search, color: Get.theme.colorScheme.onSecondary),
                      ),
                      Expanded(
                        child: Text(
                          "Search for home service...".tr,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: Get.textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            GestureDetector(
            onTap: () {
              Get.bottomSheet(
                FilterBottomSheetWidget(),
                isScrollControlled: true,
              );
            },
            child: Container(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color:  Colors.lightBlueAccent,
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,

                children: [
                  Icon(
                    IconBroken.Filter,
                    color: Colors.white,
                    size: 21,
                  ),
                ],
              ),
            ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSearchBar();
  }

  @override
  Widget get child => buildSearchBar();

  @override
  Size get preferredSize => new Size(Get.width, 80);
}
