import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../common/icon_broken.dart';

import '../../global_widgets/main_drawer_widget.dart';
import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        drawer: Drawer(
          child: MainDrawerWidget(),
          elevation: 0,
        ),
        body: controller.currentPage,
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: SvgPicture.asset('assets/img/iconWhite.svg',color: Get.theme.colorScheme.onBackground.withOpacity(.75),), title: "Home".tr,
            isIconBlend: false,
            activeIcon: CircleAvatar(
              child:Padding(
                padding: EdgeInsets.all(10),
                  child: SvgPicture.asset('assets/img/iconWhite.svg',color: Get.theme.colorScheme.background,)),
              backgroundColor: Get.theme.colorScheme.secondary,
              radius: 30,
        ),

            ),
            TabItem(icon: IconBroken.Paper, title: 'Bookings'.tr,
                isIconBlend: false,
                activeIcon: CircleAvatar(child: Icon(IconBroken.Paper,color:Get.theme.colorScheme.background,),backgroundColor: Get.theme.colorScheme.secondary,radius: 30,)
            ),
            TabItem(icon: IconBroken.Chat , title: 'Chats'.tr,
                isIconBlend: false,
                activeIcon: CircleAvatar(child: Icon(IconBroken.Chat,color:Get.theme.colorScheme.background,),backgroundColor: Get.theme.colorScheme.secondary,radius: 30,)
            ),
            TabItem(icon: IconBroken.Profile, title: 'Profile'.tr,
                isIconBlend: false,
                activeIcon: CircleAvatar(child: Icon(IconBroken.Profile,color:Get.theme.colorScheme.background,),backgroundColor: Get.theme.colorScheme.secondary,radius: 30,)
            ),
          ],
          initialActiveIndex: controller.currentIndex.value,
          backgroundColor: context.theme.scaffoldBackgroundColor,
          activeColor: Get.theme.colorScheme.secondary,
          color: Colors.grey,
          style://TabStyle.reactCircle,
          TabStyle.textIn,
          onTap: (index) {
               controller.changePage(index);
              },
        )
        // BottomNavigationBar(
        //   backgroundColor: context.theme.scaffoldBackgroundColor,
        //     selectedItemColor:  Get.theme.colorScheme.secondary,
        //     unselectedItemColor: Colors.grey,
        //     currentIndex: controller.currentIndex.value,
        //     onTap: (index) {
        //       controller.changePage(index);
        //     },
        //     items: [
        //       BottomNavigationBarItem(
        //         icon:Icon(IconBroken.Home,),
        //         label: "Home".tr,
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(IconBroken.Paper),
        //         activeIcon: CircleAvatar(child: Icon(IconBroken.Paper,),backgroundColor: Get.theme.colorScheme.secondary,),
        //         label: "Bookings".tr,
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(IconBroken.Chat),
        //         activeIcon: CircleAvatar(child: Icon(IconBroken.Chat,),backgroundColor: Get.theme.colorScheme.secondary,),
        //
        //         label: "Chats".tr,
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(IconBroken.Profile),
        //         activeIcon: CircleAvatar(child: Icon(IconBroken.Profile,),backgroundColor: Get.theme.colorScheme.secondary,),
        //
        //         label: "Account".tr,
        //       ),
        //     ],
        // )

        // CustomBottomNavigationBar(
        //   backgroundColor: context.theme.scaffoldBackgroundColor,
        //   itemColor: context.theme.colorScheme.secondary,
        //   currentIndex: controller.currentIndex.value,
        //   onChange: (index) {
        //     controller.changePage(index);
        //   },
        //   children: [
        //     CustomBottomNavigationItem(
        //       icon: Icons.home_outlined,
        //       label: "Home".tr,
        //     ),
        //     CustomBottomNavigationItem(
        //       icon: Icons.assignment_outlined,
        //       label: "Bookings".tr,
        //     ),
        //     CustomBottomNavigationItem(
        //       icon: Icons.chat_outlined,
        //       label: "Chats".tr,
        //     ),
        //     CustomBottomNavigationItem(
        //       icon: Icons.person_outline,
        //       label: "Account".tr,
        //     ),
        //   ],
        // ),
      );
    });
  }
}
