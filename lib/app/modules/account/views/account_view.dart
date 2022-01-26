import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:home_services/common/icon_broken.dart';

import '../../../../common/ui.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../global_widgets/notifications_button_widget.dart';
import '../../root/controllers/root_controller.dart';
import '../controllers/account_controller.dart';
import '../widgets/account_link_widget.dart';

class AccountView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    var _currentUser = Get.find<AuthService>().user;
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile".tr,
              style: Get.textTheme.headline4
                  .copyWith( fontWeight: FontWeight.bold)),
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          elevation: 0,
          titleSpacing: 30,
          actions: [
            NotificationsButtonWidget(
              iconColor: Get.theme.colorScheme.onBackground,
              labelColor: Get.theme.colorScheme.secondary,
            )
          ],
        ),
        body: ListView(
          primary: true,
          children: [
            SizedBox(
              height: 20,
            ),
            Obx(() {
              return Container(
                height: 220,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 180,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.background,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Get.theme.focusColor.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0, 5)),
                          ],
                        ),
                        //margin: EdgeInsets.all(50),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                _currentUser.value.name ?? '',
                                style: Get.textTheme.subtitle2,
                              ),
                              SizedBox(height: 10),
                              Text(_currentUser.value.email ?? '',
                                  style: Get.textTheme.caption),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 120,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            child: CircleAvatar(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)),
                                child: CachedNetworkImage(
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      _currentUser.value.avatar?.thumb ?? '',
                                  placeholder: (context, url) => Image.asset(
                                    'assets/img/loading.gif',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 100,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error_outline),
                                ),
                              ),
                              radius: 55,
                              backgroundColor: Get.theme.colorScheme.background,
                            ),
                            alignment: Alignment.topCenter,
                          ),
                          CircleAvatar(
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  IconBroken.Camera,
                                  size: 18,
                                  color: Get.theme.colorScheme.onBackground,
                                )),
                            radius: 18,
                            backgroundColor: Get.theme.colorScheme.background,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: Ui.getBoxDecoration(),
                    child: AccountLinkWidget(
                      icon: Icon(IconBroken.Profile,
                          color: Get.theme.colorScheme.onBackground),
                      text: Text(
                        "Profile".tr,
                        style: Get.theme.textTheme.headline4.copyWith(
                            fontSize: 15,),
                      ),
                      onTap: (e) {
                        Get.toNamed(Routes.PROFILE);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: Ui.getBoxDecoration(),
                    child: AccountLinkWidget(
                      icon: Icon(IconBroken.Paper,
                          color: Get.theme.colorScheme.onBackground),
                      text: Text(
                        "My Bookings".tr,
                        style: Get.theme.textTheme.headline4.copyWith(
                            fontSize: 15,),
                      ),
                      onTap: (e) {
                        Get.find<RootController>().changePage(1);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: Ui.getBoxDecoration(),
                    child: AccountLinkWidget(
                      icon: Icon(IconBroken.Notification,
                          color: Get.theme.colorScheme.onBackground),
                      text: Text(
                        "Notifications".tr,
                        style: Get.theme.textTheme.headline4.copyWith(
                            fontSize: 15,),
                      ),
                      onTap: (e) {
                        Get.toNamed(Routes.NOTIFICATIONS);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: Ui.getBoxDecoration(),
                    child: AccountLinkWidget(
                      icon: Icon(IconBroken.Chat,
                          color: Get.theme.colorScheme.onBackground),
                      text: Text(
                        "Messages".tr,
                        style: Get.theme.textTheme.headline4.copyWith(
                            fontSize: 15,),
                      ),
                      onTap: (e) {
                        Get.find<RootController>().changePage(2);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: Ui.getBoxDecoration(),
                    child: AccountLinkWidget(
                      icon: Icon(IconBroken.Setting,
                          color: Get.theme.colorScheme.onBackground),
                      text: Text(
                        "Settings".tr,
                        style: Get.theme.textTheme.headline4.copyWith(
                            fontSize: 15,),
                      ),
                      onTap: (e) {
                        Get.toNamed(Routes.SETTINGS);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: Ui.getBoxDecoration(),
                    child: AccountLinkWidget(
                      icon: Icon(Icons.translate_outlined,
                          color: Get.theme.colorScheme.onBackground),
                      text: Text(
                        "Languages".tr,
                        style: Get.theme.textTheme.headline4.copyWith(
                            fontSize: 15,),
                      ),
                      onTap: (e) {
                        Get.toNamed(Routes.SETTINGS_LANGUAGE);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: Ui.getBoxDecoration(),
                    child: AccountLinkWidget(
                      icon: Icon(Icons.brightness_6_outlined,
                          color: Get.theme.colorScheme.onBackground),
                      text: Text(
                        "Theme Mode".tr,
                        style: Get.theme.textTheme.headline4.copyWith(
                            fontSize: 15,),
                      ),
                      onTap: (e) {
                        Get.toNamed(Routes.SETTINGS_THEME_MODE);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: Ui.getBoxDecoration(),
                    child: AccountLinkWidget(
                      icon: Icon(IconBroken.Info_Circle,
                          color: Get.theme.colorScheme.onBackground),
                      text: Text(
                        "Help & FAQ".tr,
                        style: Get.theme.textTheme.headline4.copyWith(
                            fontSize: 15,),
                      ),
                      onTap: (e) {
                        Get.toNamed(Routes.HELP);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: Ui.getBoxDecoration(),
                    child: AccountLinkWidget(
                      icon: Icon(
                        IconBroken.Logout,
                        color: Get.theme.colorScheme.onBackground,
                      ),
                      text: Text(
                        "Logout".tr,
                        style: Get.theme.textTheme.headline4.copyWith(
                            fontSize: 15,),
                      ),
                      onTap: (e) async {
                        await Get.find<AuthService>().removeCurrentUser();
                        Get.find<RootController>().changePage(0);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
