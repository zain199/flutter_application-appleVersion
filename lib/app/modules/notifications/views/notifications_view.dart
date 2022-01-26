import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services/common/icon_broken.dart';
import '../../../models/notification_model.dart' as model;

import '../../../providers/laravel_provider.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../controllers/notifications_controller.dart';
import '../widgets/booking_notification_item_widget.dart';
import '../widgets/message_notification_item_widget.dart';
import '../widgets/notification_item_widget.dart';

class NotificationsView extends GetView<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications".tr,
          style: Get.textTheme.headline4,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Get.theme.hintColor),
          onPressed: () => {Get.back()},
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Get.theme.colorScheme.onBackground ,))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<LaravelApiClient>().forceRefresh();
          await controller.refreshNotifications(showMessage: true);
          Get.find<LaravelApiClient>().unForceRefresh();
        },
        child: ListView(
          primary: true,
          children: <Widget>[
            notificationsList(),
          ],
        ),
      ),
    );
  }

  Widget notificationsList() {


    return Obx(() {
      if (!controller.notifications.isNotEmpty) {
        return Center(
          child: CircularLoadingWidget(
            height: 300,
            onCompleteText: "Notification List is Empty".tr,
          ),
        );
      } else {
        var _notifications = controller.notifications;
        return ListView.separated(
            itemCount: _notifications.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 7);
            },
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              var _notification = controller.notifications.elementAt(index);
              if (_notification.data['message_id'] != null) {
                return MessageNotificationItemWidget(notification: _notification);
              } else if (_notification.data['booking_id'] != null) {
                return BookingNotificationItemWidget(notification: _notification);
              } else {
                return NotificationItemWidget(
                  notification: _notification,
                  onDismissed: (notification) {
                    controller.removeNotification(notification);
                  },
                  onTap: (notification) async {
                    await controller.markAsReadNotification(notification);
                  },
                );
             }
            });
      }
    });
  }
}
