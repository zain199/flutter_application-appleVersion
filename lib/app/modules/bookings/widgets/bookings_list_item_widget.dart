/*
 * Copyright (c) 2020 .
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services/app/modules/bookings/views/booking_view.dart';
import 'package:home_services/icon_broken.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../routes/app_routes.dart';
import 'booking_options_popup_menu_widget.dart';

class BookingsListItemWidget extends StatelessWidget {
  const BookingsListItemWidget({
    Key key,
    @required Booking booking,
  })  : _booking = booking,
        super(key: key);

  final Booking _booking;

  @override
  Widget build(BuildContext context) {
    Color _color = _booking.cancel ? Get.theme.focusColor :Get
        .theme.colorScheme.secondary;
    return Dismissible(
      key: Key('dismiss'),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.all(20),
         color: Get.theme.scaffoldBackgroundColor,
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Container(
            width: 50,
            height: 50,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: Colors.red[300],
              borderRadius: BorderRadius.circular(18),
              boxShadow: [BoxShadow(
                color: Colors.red.withOpacity(.2),
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(0.0,2.5),
              )]
            ),
            child: Icon(IconBroken.Delete,color: Get.theme.colorScheme.background,size: 30,),
          ),
        ),
      ),

      child: GestureDetector(
        onTap: () {
         // Get.toNamed(Routes.BOOKING, arguments: _booking);
          Navigator.push(context, MaterialPageRoute(builder: (context)=> BookingView(_booking)));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: Ui.getBoxDecoration(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: CachedNetworkImage(
                      height: 85,
                      width: 85,
                      fit: BoxFit.cover,
                      imageUrl: _booking.eService.firstImageThumb,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 80,
                      ),
                      errorWidget: (context, url, error) => Container(
                        child: Icon(Icons.error_outline),
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12),
              Expanded(
                child: Opacity(
                  opacity: _booking.cancel ? 0.3 : 1,
                  child: Wrap(
                    runSpacing: 10,
                    alignment: WrapAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                               _booking.eService?.name ?? '',
                              style: Get.textTheme.bodyText2,
                              maxLines: 3,
                              //textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Ui.getPrice(
                                _booking.getTotal(),
                                style: Get.textTheme.headline6
                                    .merge(TextStyle(color: _color)),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.star,color: Colors.amber,size: 20,),
                                  Text(
                                    _booking.eService.totalReviews.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: Get.textTheme.bodyText2,
                                  ),
                                ],
                            ),
                          ),
                        ],
                      ),

                      // time view and date
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // date view
                          Expanded(
                            child: Row(
                              children: [
                                Icon(IconBroken.Calendar,color: Colors.grey,),
                                SizedBox(width: 5,),
                                Text(
                                  DateFormat.yMMMd(Get.locale.toString()).format(_booking.bookingAt),

                                    style: Get.textTheme.caption)
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
                          ),

                          // time view
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconBroken.Time_Circle, color:Colors.grey),
                                SizedBox(width: 5,),
                                Text(
                                    '${DateFormat('HH:mm a', Get.locale.toString()).format(DateTime.now())}',
                                    style: Get.textTheme.caption)
                              ],
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
