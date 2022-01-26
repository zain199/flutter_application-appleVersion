import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/icon_broken.dart';

import '../../../../common/helper.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    controller.loginFormKey = new GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
          // appBar: AppBar(
          //   title: Text(
          //     "Login".tr,
          //     style: Get.textTheme.headline6.merge(TextStyle(color: context.theme.primaryColor)),
          //   ),
          //   centerTitle: true,
          //   backgroundColor: Get.theme.colorScheme.secondary,
          //   automaticallyImplyLeading: false,
          //   elevation: 0,
          //   leading: new IconButton(
          //     icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
          //     onPressed: () => {Get.find<RootController>().changePageOutRoot(0)},
          //   ),
          // ),
          body: CustomScrollView(
          slivers: [
            SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 200,
                elevation: 0,
                floating: true,
                //iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                centerTitle: true,
                automaticallyImplyLeading: false,
                // leading: new IconButton(
                //   icon: Container(
                //     decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                //       BoxShadow(
                //         color: Get.theme.primaryColor.withOpacity(0.5),
                //         blurRadius: 20,
                //       ),
                //     ]),
                //     child: new Icon(Icons.arrow_back_outlined,
                //         color: Get.theme.primaryColor),
                //   ),
                //   onPressed: () => {Get.back()},
                // ),

                // cover on the top image with indicator
                flexibleSpace: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Get.theme.primaryColor //Get.theme.ye
                      ),
                  child: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/img/signUp.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                )),
            SliverToBoxAdapter(
              child: Container(
                color: Get.theme.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Form(
                    key: controller.loginFormKey,
                    child: Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Log in',
                                  style: Get.textTheme.headline4
                                      .copyWith(fontSize: 30),
                                ),
                                Text(
                                  "Hey, Welcome Back",
                                  style: Get.textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            if (controller.loading.isTrue)
                              return CircularLoadingWidget(height: 300);
                            else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      "Email Address".tr,
                                      style: Get.textTheme.bodyText1
                                          .copyWith(fontSize: 16),
                                    ),
                                  ),
                                  TextFieldWidget(
                                    //labelText: "Email Address".tr,
                                    hintText: "johndoe@gmail.com".tr,
                                    initialValue:
                                        controller.currentUser?.value?.email,
                                    onSaved: (input) =>
                                        controller.currentUser.value.email = input,
                                    validator: (input) => !input.contains('@')
                                        ? "Should be a valid email".tr
                                        : null,
                                    iconData: IconBroken.Message,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      "Password".tr,
                                      style: Get.textTheme.bodyText1
                                          .copyWith(fontSize: 16),
                                    ),
                                  ),
                                  Obx(() {
                                    return TextFieldWidget(
                                      //labelText: "Password".tr,
                                      hintText: "••••••••••••".tr,
                                      initialValue:
                                          controller.currentUser?.value?.password,
                                      onSaved: (input) => controller
                                          .currentUser.value.password = input,
                                      validator: (input) => input.length < 3
                                          ? "Should be more than 3 characters".tr
                                          : null,
                                      obscureText: controller.hidePassword.value,
                                      iconData: IconBroken.Lock,
                                      keyboardType: TextInputType.visiblePassword,
                                      // suffixIcon: IconButton(
                                      //   onPressed: () {
                                      //     controller.hidePassword.value = !controller.hidePassword.value;
                                      //   },
                                      //   color: Theme.of(context).focusColor,
                                      //   icon: Icon(controller.hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                      // ),
                                    );
                                  }),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Get.toNamed(Routes.FORGOT_PASSWORD);
                                        },
                                        child: Text(
                                          "Forgot Password?".tr,
                                          style: Get.textTheme.caption
                                              .copyWith(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ).paddingSymmetric(horizontal: 20),
                                  BlockButtonWidget(
                                    onPressed: () {
                                      controller.login();
                                    },
                                    color: Get.theme.colorScheme.secondary,
                                    text: Text(
                                      "Login".tr,
                                      style: Get.textTheme.headline6.merge(
                                          TextStyle(color: Get.theme.primaryColor)),
                                    ),
                                  ).paddingSymmetric(horizontal: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account?".tr,
                                        style: Get.textTheme.headline4
                                            .copyWith(fontSize: 14),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.toNamed(Routes.REGISTER);
                                        },
                                        child: Text(
                                          "Sign Up".tr,
                                          style: TextStyle(
                                              decoration: TextDecoration.underline),
                                        ),
                                      ),
                                    ],
                                  ).paddingSymmetric(vertical: 20),
                                ],
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
      )),
    );
  }
}
