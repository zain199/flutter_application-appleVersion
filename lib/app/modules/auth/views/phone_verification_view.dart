import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/setting_model.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/auth_controller.dart';

class PhoneVerificationView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
          // appBar: AppBar(
          //   title: Text(
          //     "Phone Verification".tr,
          //     style: Get.textTheme.headline6.merge(TextStyle(color: context.theme.primaryColor)),
          //   ),
          //   centerTitle: true,
          //   backgroundColor: Get.theme.colorScheme.secondary,
          //   automaticallyImplyLeading: false,
          //   elevation: 0,
          //   leading: new IconButton(
          //     icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
          //     onPressed: () => {Get.back()},
          //   ),
          // ),
          body: CustomScrollView(
        primary: true,
        slivers: [
          SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              expandedHeight: 200,
              elevation: 0,
              floating: true,
              //iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: new IconButton(
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
              )),
          SliverToBoxAdapter(
            child: Container(
              color: Get.theme.primaryColor,
              child: Obx(() {
                if (controller.loading.isTrue) {
                  return CircularLoadingWidget(height: 300);
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Verification Code".tr,
                                  style: Get.theme.textTheme.headline4,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Enter The 6 Digit Code That You Received On Your Email "
                                      .tr,
                                  style: Get.theme.textTheme.caption,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 40,
                          ),

                          // Text(
                          //   "We sent the OTP code to your phone, please check it and enter below"
                          //       .tr,
                          //   style: Get.textTheme.bodyText1,
                          //   textAlign: TextAlign.center,
                          // ).paddingSymmetric(horizontal: 20, vertical: 20),

                          Row(
                            children: [
                              Expanded(
                                child: Container(

                                  child: OTPTextField(
                                    length: 6,
                                    fieldWidth: 50 ,

                                    otpFieldStyle: OtpFieldStyle(
                                      disabledBorderColor: Colors.grey[300] ,
                                      enabledBorderColor: Colors.grey,
                                    ),
                                    margin:EdgeInsets.all(2),

                                    style: Get.textTheme.headline4,
                                    textFieldAlignment: MainAxisAlignment.spaceAround,
                                    fieldStyle: FieldStyle.box,
                                    onCompleted: (pin) {
                                      controller.smsSent.value = pin ;
                                    },
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                ),
                              ),
                            ],
                          ),

                          //  TextFieldWidget(
                          //   labelText: "OTP Code".tr,
                          //   hintText: "- - - - - -".tr,
                          //   style: Get.textTheme.headline4
                          //       .merge(TextStyle(letterSpacing: 8)),
                          //   textAlign: TextAlign.center,
                          //   keyboardType: TextInputType.number,
                          //   onChanged: (input) => controller.smsSent.value = input,
                          //   // iconData: Icons.add_to_home_screen_outlined,
                          // ),

                          BlockButtonWidget(
                            onPressed: () async {
                              await controller.verifyPhone();
                            },
                            color: Get.theme.colorScheme.secondary,
                            text: Text(
                              "Next".tr,
                              style: Get.textTheme.headline6.merge(
                                  TextStyle(color: Get.theme.primaryColor)),
                            ),
                          ).paddingSymmetric(vertical: 30, horizontal: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Haven’t received the code ? ".tr,
                                style: Get.textTheme.headline4
                                    .copyWith(fontSize: 14),
                              ),
                              TextButton(
                                onPressed: () {
                                  controller.resendOTPCode();
                                },
                                child: Text(
                                  "Resend".tr,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
              }),
            ),
          ),
        ],
      )),
    );
  }
}
