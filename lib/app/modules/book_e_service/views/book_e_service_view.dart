import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services/app/services/settings_service.dart';
import 'package:home_services/common/icon_broken.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/block_button_widget.dart';
import '../controllers/book_e_service_controller.dart';

class BookEServiceView extends GetView<BookEServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Book the Service".tr,
            style: context.textTheme.headline4,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Get.theme.hintColor),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
        ),

        //containue button
        bottomNavigationBar: buildBlockButtonWidget(controller.booking.value),
        body: ListView(
          children: [
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Delivery Address".tr,
                style: Get.theme.textTheme.headline4
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            // show location
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              decoration: Ui.getBoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Icon(Icons.place_outlined, color: Get.theme.focusColor),
                      SizedBox(width: 25),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              return Text(
                                  controller.currentAddress?.address ??
                                      "Loading...".tr,
                                  style: Get.textTheme.bodyText2);
                            }),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      SizedBox(width: 8,),
                      MaterialButton(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        onPressed: () {
                          Get.toNamed(Routes.SETTINGS_ADDRESS_PICKER);
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 6,
                          children: [
                            Text("New".tr, style: Get.textTheme.subtitle1),
                            Icon(
                              Icons.my_location,
                              color: Get.theme.colorScheme.secondary,
                              size: 20,
                            ),
                          ],
                        ),
                        elevation: 0,
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Time & Date".tr,
                style: Get.theme.textTheme.headline4
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            // as soon as possible button
            Obx(() {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: Ui.getBoxDecoration(
                    color: controller.getColor(!controller.scheduled.value)),
                child: Theme(
                  data: ThemeData(
                    toggleableActiveColor: Get.theme.primaryColor,
                  ),
                  child: RadioListTile(
                    value: false,
                    groupValue: controller.scheduled.value,
                    onChanged: (value) {
                      controller.toggleScheduled(value);
                    },
                    title: Text("As Soon as Possible".tr,
                            style: controller
                                .getTextTheme(!controller.scheduled.value))
                        .paddingSymmetric(vertical: 20),
                  ),
                ),
              );
            }),

            // schedule an order button
            Obx(() {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: Ui.getBoxDecoration(
                    color: controller.getColor(controller.scheduled.value)),
                child: Theme(
                  data: ThemeData(
                    toggleableActiveColor: Get.theme.primaryColor,
                  ),
                  child: RadioListTile(
                    value: true,
                    groupValue: controller.scheduled.value,
                    onChanged: (value) {
                      controller.toggleScheduled(value);
                    },
                    title: Text("Schedule an Order".tr,
                            style: controller
                                .getTextTheme(controller.scheduled.value))
                        .paddingSymmetric(vertical: 20),
                  ),
                ),
              );
            }),

            // time and date picker
            Obx(() {
              return AnimatedOpacity(
                opacity: controller.scheduled.value ? 1 : 0,
                duration: Duration(milliseconds: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(() {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        //margin: EdgeInsets.symmetric(horizontal: 20, vertical: controller.scheduled.value ? 20 : 0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: controller.scheduled.value ? 10 : 0),
                        decoration: Ui.getBoxDecoration(),
                        child: Row(
                          children: [
                            Icon(IconBroken.Calendar),
                            Obx(() {
                              return MaterialButton(
                                elevation: 0,
                                onPressed: () {
                                  controller.showMyDatePicker(context);
                                },
                                shape: StadiumBorder(),
                                //color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                                child: controller.booking.value.bookingAt !=
                                        null
                                    ? Text(
                                        //DateFormat.yMMMMEEEEd(Get.locale.toString()).format(controller.booking.value.bookingAt)
                                        '${DateFormat.MMMd(Get.locale.toString()).format(controller.booking.value.bookingAt)}',
                                        style: Get.textTheme.bodyText2)
                                    : Text("Select Date".tr,
                                        style: Get.textTheme.bodyText2),
                              );
                            })
                          ],
                        ),
                      );
                    }),
                    Obx(() {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        // margin: EdgeInsets.symmetric(horizontal: 20, vertical: controller.scheduled.value ? 20 : 0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: controller.scheduled.value ? 10 : 0),
                        decoration: Ui.getBoxDecoration(),
                        child: Row(
                          children: [
                            Icon(IconBroken.Time_Circle),
                            Obx(() {
                              return MaterialButton(
                                onPressed: () {
                                  controller.showMyTimePicker(context);
                                },
                                shape: StadiumBorder(),
                                //color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                                child: controller.booking.value.bookingAt !=
                                        null
                                    //&& DateFormat('HH:mm a', Get.locale.toString()).format(controller.booking.value.bookingAt) != '00:00 AM'
                                    ? Text(
                                        '${DateFormat('HH:mm a', Get.locale.toString()).format(controller.booking.value.bookingAt)}',
                                        style: Get.textTheme.bodyText2)
                                    : Text("Select time".tr,
                                        style: Get.textTheme.bodyText2),
                                elevation: 0,
                              );
                            })
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            }),
          ],
        ));
  }

  Widget buildBlockButtonWidget(Booking _booking) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Get.theme.focusColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -5)),
          ],
        ),
        child: BlockButtonWidget(
          text: SizedBox(
            width: double.infinity,
            child: Text(
              "Continue".tr,
              textAlign: TextAlign.center,
              style: Get.textTheme.headline6.merge(
                TextStyle(color: Get.theme.primaryColor),
              ),
            ),
          ),
          color: Get.theme.colorScheme.secondary,
          onPressed:
               (!(Get.find<SettingsService>().address.value?.isUnknown() ??
                       true)) ?
                  () async {
            if(controller.booking.value.bookingAt==null)
              controller.booking.value.bookingAt=DateTime.now();
            await Get.toNamed(Routes.BOOKING_SUMMARY);
          }
                 : null,
        ).paddingOnly(right: 20, left: 20));
  }
}
