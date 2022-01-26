import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    controller.forgotPasswordFormKey = new GlobalKey<FormState>();
    return Scaffold(
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
            leading: IconButton(
              icon: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Get.theme.primaryColor.withOpacity(0.5),
                    blurRadius: 20,
                  ),
                ]),
                child: new Icon(Icons.arrow_back_outlined,
                    color: Get.theme.primaryColor),
              ),
              onPressed: () => {Get.back()},
            ),

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
            )
        ),
        SliverToBoxAdapter(
            child: Container(
              color: Get.theme.primaryColor,
              child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Form(
                  key: controller.forgotPasswordFormKey,
                  child: Obx(() {
                    if (controller.loading.isTrue)
                      return CircularLoadingWidget(height: 300);
                    else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text("Forget Password".tr , style: Get.theme.textTheme.headline4,),
                                SizedBox(height: 10,),
                                Text("Enter Your Email , We Will Send 4 Digit Code".tr , style: Get.theme.textTheme.caption,),

                                SizedBox(height: 40,),
                                Text("Email" , style: Get.textTheme.subtitle1.copyWith(
                                  color: Get.theme.colorScheme.onBackground,

                                ),),
                              ],
                            ),
                          ),
                          TextFieldWidget(
                            //labelText: "Email Address".tr,
                            hintText: "johndoe@gmail.com".tr,
                            initialValue: controller.currentUser?.value?.email,
                            onSaved: (input) =>
                                controller.currentUser.value.email = input,
                            validator: (input) => !GetUtils.isEmail(input)
                                ? "Should be a valid email".tr
                                : null,
                            iconData: Icons.email_outlined,
                          ),
                          BlockButtonWidget(
                            onPressed: controller.sendResetLink,
                            color: Get.theme.colorScheme.secondary,
                            text: Text(
                              "Send Reset Link".tr,
                              style: Get.textTheme.headline6
                                  .merge(TextStyle(color: Get.theme.primaryColor)),
                            ),
                          ).paddingSymmetric(vertical: 35, horizontal: 20),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     TextButton(
                          //       onPressed: () {
                          //         Get.offAllNamed(Routes.REGISTER);
                          //       },
                          //       child: Text("You don't have an account?".tr),
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     TextButton(
                          //       onPressed: () {
                          //         Get.offAllNamed(Routes.REGISTER);
                          //       },
                          //       child: Text("You remember my password!".tr),
                          //     ),
                          //   ],
                          // ),
                        ],
                      );
                    }
                  }),
              ),
        ),
            )),

      ],
    ));
  }
}
