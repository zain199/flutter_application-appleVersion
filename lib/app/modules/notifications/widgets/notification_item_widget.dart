import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services/common/icon_broken.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../common/ui.dart';
import '../../../models/notification_model.dart' as model;

class NotificationItemWidget extends StatelessWidget {
  NotificationItemWidget({Key key, this.notification, this.onDismissed, this.onTap, this.icon}) : super(key: key);
  final model.Notification notification;
  final ValueChanged<model.Notification> onDismissed;
  final ValueChanged<model.Notification> onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(this.notification.hashCode.toString()),
      background: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: Ui.getBoxDecoration(color: Colors.red),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        onDismissed(this.notification);
        // Then show a snackbar
        Get.showSnackbar(Ui.SuccessSnackBar(message: "The notification is deleted".tr));
      },
      child: GestureDetector(
        onTap: () {
         onTap(notification);
        },
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: Ui.getBoxDecoration(color: this.notification.read ?Get.theme.primaryColor :Get.theme.focusColor.withOpacity(0.15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(.3),
                    ),
                    child: //icon ??
                        Icon(

                          Icons.notifications_outlined,
                          color: Get.theme.scaffoldBackgroundColor,
                          size: 38,
                        ),
                  ),
                  Positioned(
                    right: -15,
                    bottom: -30,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -20,
                    top: -55,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: 15),
              Container(
                height: 50,
                width: Get.size.width-145,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        this.notification.getMessage(),

                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: Get.textTheme.bodyText1.merge(TextStyle(fontWeight: notification.read ? FontWeight.w300 :FontWeight.w600)),
                      ),
                    ),

                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional.bottomStart,
                        child: Text(
                          DateFormat('d, MMMM y | HH:mm', Get.locale.toString()).format(this.notification.createdAt),
                          style: Get.textTheme.caption,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
