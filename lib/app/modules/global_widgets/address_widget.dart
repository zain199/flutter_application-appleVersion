import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../services/settings_service.dart';

class AddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Row(
        children: [
          Icon(Icons.place_outlined,color:Get.theme.colorScheme.background,size: 18,),
          SizedBox(width: 5),
          Expanded(
            child: GestureDetector(

              onTap: () {
                Get.toNamed(Routes.SETTINGS_ADDRESSES);
              },
              child: Obx(() {
                if (Get.find<SettingsService>().address.value?.isUnknown() ?? true) {
                  return Text("Please choose your address".tr, style: Get.textTheme.bodyText1.copyWith(color:Get.theme.colorScheme.background));
                }
                return Text(Get.find<SettingsService>().address.value.address, style: Get.textTheme.bodyText1.copyWith(color:Get.theme.colorScheme.background));
              }),
            ),
          ),
          SizedBox(width: 10),

          InkWell(
            child: Icon(Icons.arrow_drop_down, color:Get.theme.colorScheme.background,size: 18,),
            onTap: () async {
              Get.toNamed(Routes.SETTINGS_ADDRESS_PICKER);
            },
          )
        ],
      ),
    );
  }
}
