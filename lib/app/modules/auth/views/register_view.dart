import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_services/common/icon_broken.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../root/controllers/root_controller.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    controller.registerFormKey = new GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: ()async{
          Get.find<RootController>().changePage(0);
        return true ;
      },
      child: Scaffold(
        // appBar: AppBar(
        //
        //   systemOverlayStyle: SystemUiOverlayStyle(
        //     statusBarColor: Colors.transparent,
        //   ),
        //   backgroundColor: Colors.transparent,
        //  // automaticallyImplyLeading: false,
        //   elevation: 0,
        //   leading: new IconButton(
        //     icon: new Icon(Icons.arrow_back,
        //         color: Get.theme.colorScheme.background),
        //     onPressed: () => {Get.find<RootController>().changePageOutRoot(0)},
        //   ),
        // ),
        body: SingleChildScrollView(
         // physics: BouncingScrollPhysics(),
          primary: false,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/sign.png'),
                fit: BoxFit.cover
              )
            ),
            child: Container(
              width: Get.size.width,
              height: Get.size.height,
              padding: EdgeInsets.only(
                top: 220
              ),
              child: Form(
                key: controller.registerFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                        child: Text('Sign up',style: Get.theme.textTheme.headline1.copyWith(fontSize: 35,color: Colors.black),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
                        child: Text('Create new account',style: Get.theme.textTheme.caption.copyWith(fontSize: 16),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                        child: Text('Name',style: TextStyle(color: Colors.black),),
                      ),
                      TextFieldWidget(
                        labelText: "Full Name".tr,
                        hintText: "John Doe".tr,
                        initialValue: controller.currentUser?.value?.name,
                        onSaved: (input) => controller.currentUser.value.name = input,
                        validator: (input) => input.length < 3 ? "Should be more than 3 characters".tr : null,
                        iconData: Icons.person_outline,
                        isFirst: true,
                        isLast: false,

                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                        child: Text('Email',style: TextStyle(color: Colors.black),),
                      ),
                      TextFieldWidget(
                        labelText: "Email Address".tr,
                        hintText: "johndoe@gmail.com".tr,
                        initialValue: controller.currentUser?.value?.email,
                        onSaved: (input) => controller.currentUser.value.email = input,
                        validator: (input) => !input.contains('@') ? "Should be a valid email".tr : null,
                        iconData: IconBroken.Message,
                        isFirst: false,
                        isLast: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                        child: Text('Phone',style: TextStyle(color: Colors.black),),
                      ),
                      TextFieldWidget(
                        labelText: "Phone Number".tr,
                        hintText: "+1 223 665 7896".tr,
                        initialValue: controller.currentUser?.value?.phoneNumber,
                        onSaved: (input) {
                          if (input.startsWith("00")) {
                            input = "+" + input.substring(2);
                          }
                          return controller.currentUser.value.phoneNumber = input;
                        },
                        validator: (input) {
                          return !input.startsWith('\+') && !input.startsWith('00') ? "Should be valid mobile number with country code" : null;
                        },
                        iconData: Icons.phone_android_outlined,
                        isLast: false,
                        isFirst: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                        child: Text('Password',style: TextStyle(color: Colors.black),),
                      ),
                      Obx(() {
                        return TextFieldWidget(
                          labelText: "Password".tr,
                          hintText: "••••••••••••".tr,
                          initialValue: controller.currentUser?.value?.password,
                          onSaved: (input) => controller.currentUser.value.password = input,
                          validator: (input) => input.length < 3 ? "Should be more than 3 characters".tr : null,
                          obscureText: controller.hidePassword.value,
                          iconData: IconBroken.Lock,
                          keyboardType: TextInputType.visiblePassword,
                          isLast: true,
                          isFirst: false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.hidePassword.value = !controller.hidePassword.value;
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(controller.hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                          ),
                        );
                      }),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        children: [
                          SizedBox(
                            width: Get.width,
                            child: BlockButtonWidget(
                              onPressed: () {
                                controller.register();
                               // Get.offAllNamed(Routes.PHONE_VERIFICATION);
                              },
                              color: Get.theme.colorScheme.secondary,
                              text: Text(
                                "Register".tr,
                                style: Get.textTheme.headline6
                                    .merge(TextStyle(color: Get.theme.primaryColor)),
                              ),
                            ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                          ),
                          Row(
                            children: [
                              Text("You already have an account?".tr,style: TextStyle(color: Colors.black),),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.LOGIN);
                                },
                                child: Text("Log in".tr,style: TextStyle(decoration: TextDecoration.underline),),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}
