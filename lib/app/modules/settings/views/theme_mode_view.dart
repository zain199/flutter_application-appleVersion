import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../controllers/theme_mode_controller.dart';

class ThemeModeView extends GetView<ThemeModeController> {
  final bool hideAppBar;

  ThemeModeView({this.hideAppBar = false});

  bool dark;

  @override
  Widget build(BuildContext context) {
    dark=controller.selectedThemeMode==ThemeMode.dark?true : false;
    return Scaffold(
      appBar: hideAppBar
          ? null
          : AppBar(
              title: Text(
                "Theme Mode".tr,
                style: context.textTheme.headline4
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_outlined,
                    color: Get.theme.hintColor),
                onPressed: () => Get.back(),
              ),
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_vert, color: Get.theme.hintColor)),
                SizedBox(
                  width: 10,
                )
              ],
            ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          //padding: EdgeInsets.symmetric(vertical: 5),
          //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: Ui.getBoxDecoration(),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Icon(Icons.dark_mode),
                SizedBox(
                  width: 10,
                ),
                Text("Dark Mode".tr,
                    style: Get.textTheme.headline4.copyWith(fontSize: 16)),
                Spacer(),

                Switch(
                  value: dark,
                  onChanged: (val) {
                    dark = !dark;

                    dark
                        ? controller.changeThemeMode(ThemeMode.dark)
                        : controller.changeThemeMode(ThemeMode.light);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // Column(
      //   children: [
      //
      //     Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: Container(
      //         //padding: EdgeInsets.symmetric(vertical: 5),
      //         //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //         decoration: Ui.getBoxDecoration(),
      //         child: RadioListTile(
      //           value: ThemeMode.light,
      //           groupValue: controller.selectedThemeMode.value,
      //           onChanged: (value) {
      //             controller.changeThemeMode(value);
      //           },
      //           title: Text("Light Theme".tr, style: Get.textTheme.bodyText2),
      //         ),
      //       ),
      //     ),
      //
      //     Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: Container(
      //         //padding: EdgeInsets.symmetric(vertical: 5),
      //         //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //         decoration: Ui.getBoxDecoration(),
      //         child: RadioListTile(
      //           value: ThemeMode.dark,
      //           groupValue: controller.selectedThemeMode.value,
      //           onChanged: (value) {
      //             controller.changeThemeMode(value);
      //           },
      //           title: Text("Dark Theme".tr, style: Get.textTheme.bodyText2),
      //         ),
      //       ),
      //     ),
      //
      //     Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: Container(
      //         //padding: EdgeInsets.symmetric(vertical: 5),
      //         //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //         decoration: Ui.getBoxDecoration(),
      //         child: RadioListTile(
      //           value: ThemeMode.system,
      //           groupValue: controller.selectedThemeMode.value,
      //           onChanged: (value) {
      //             controller.changeThemeMode(value);
      //           },
      //           title:
      //               Text("System Theme".tr, style: Get.textTheme.bodyText2),
      //         ),
      //       ),
      //     ),
      //   ],
      // )
    );
  }
}
