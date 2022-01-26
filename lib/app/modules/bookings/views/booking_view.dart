import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services/app/modules/bookings/widgets/booking_details_widget.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../../providers/laravel_provider.dart';
import '../controllers/booking_controller.dart';
import '../widgets/booking_actions_widget.dart';
import '../widgets/booking_row_widget.dart';
import '../widgets/booking_til_widget.dart';
import '../widgets/booking_title_bar_widget.dart';

class BookingView extends GetView<BookingController> {
  final Booking booking;
  BookingView(this.booking);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_outlined, color: Get.theme.hintColor),
          onPressed: () => Get.back(),
        ),
      ),
      //bottomNavigationBar: BookingActionsWidget(),
      body: RefreshIndicator(
          onRefresh: () async {
            Get.find<LaravelApiClient>().forceRefresh();
            controller.refreshBooking(showMessage: true);
            Get.find<LaravelApiClient>().unForceRefresh();
          },
          child: CustomScrollView(
            primary: true,
            shrinkWrap: false,
            slivers: <Widget>[
              // SliverAppBar(
              //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              //   expandedHeight: 370,
              //   elevation: 0,
              //   // pinned: true,
              //   floating: true,
              //   iconTheme: IconThemeData(color: Get.theme.primaryColor),
              //   centerTitle: true,
              //   automaticallyImplyLeading: false,
              //   leading: new IconButton(
              //     icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
              //     onPressed: () => {Get.back()},
              //   ),
              //   bottom: buildBookingTitleBarWidget(controller.booking),
              //   flexibleSpace: FlexibleSpaceBar(
              //     collapseMode: CollapseMode.parallax,
              //     background: Obx(() {
              //       return GoogleMap(
              //         compassEnabled: false,
              //         scrollGesturesEnabled: false,
              //         tiltGesturesEnabled: false,
              //         myLocationEnabled: false,
              //         myLocationButtonEnabled: false,
              //         zoomControlsEnabled: false,
              //         zoomGesturesEnabled: false,
              //         mapToolbarEnabled: false,
              //         rotateGesturesEnabled: false,
              //         liteModeEnabled: true,
              //        mapType: MapType.normal,
              //        initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
              //        markers: Set.from(controller.allMarkers),
              //        onMapCreated: (GoogleMapController _con) {
              //          controller.mapController = _con;
              //         },
              //      );
              //     }),
              //   ).marginOnly(bottom: 68),
              // ),
              SliverToBoxAdapter(
                // child:
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  padding: EdgeInsets.all(20),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.background,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: CachedNetworkImage(
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                              imageUrl: booking.eService.firstImageThumb,
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
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking.eService.name,
                                style: Get.theme.textTheme.headline4
                                    .copyWith(fontWeight: FontWeight.bold,fontSize: 17),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 17, vertical: 10),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green[300],
                                ),
                                child: Text(
                                  booking.status.status,
                                  style: Get.theme.textTheme.caption.copyWith(
                                      color: Get.theme.colorScheme.background),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          BookingDetailsWidget(
                            name: 'Date',
                            value: Text('${DateFormat.MMMMd(Get.locale.toString()).format(booking.bookingAt)}'),
                          ),
                           BookingDetailsWidget(
                             name: 'Time',
                             value: Text(TimeOfDay.fromDateTime(booking.bookingAt).format(context)),
                           ),
                          if (booking.payment!=null&&booking.payment.paymentMethod != null)
                          BookingDetailsWidget(
                            name: 'Payment Method',
                            value: Text(booking.payment.paymentMethod?.getName())
                          ),
                           BookingDetailsWidget(
                               name: 'Amount',
                               value: Text('${booking.getSubtotal()} \$')
                           ),
                           BookingDetailsWidget(
                               name: 'Tax',
                               value: Text('${booking.getTaxesValue()} \$')
                           ),
                           BookingDetailsWidget(
                               name: 'Total',
                               value: Text('${booking.getTotal()} \$')
                           ),
                           BookingDetailsWidget(
                               name: 'Address',
                               value: Expanded(child: Text('${booking.address.address}',maxLines: 1,overflow: TextOverflow.ellipsis,))
                           ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  BookingTitleBarWidget buildBookingTitleBarWidget(Rx<Booking> _booking) {
    return BookingTitleBarWidget(
      title: Obx(() {
        return Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _booking.value.eService?.name ?? '',
                    style:
                        Get.textTheme.headline5.merge(TextStyle(height: 1.1)),
                    overflow: TextOverflow.fade,
                  ),
                  Row(
                    children: [
                      Icon(Icons.person_outline, color: Get.theme.focusColor),
                      SizedBox(width: 8),
                      Text(
                        _booking.value.user?.name ?? '',
                        style: Get.textTheme.bodyText1,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.place_outlined, color: Get.theme.focusColor),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(_booking.value.address?.address ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.bodyText1),
                      ),
                    ],
                    // spacing: 8,
                    // crossAxisAlignment: WrapCrossAlignment.center,
                  ),
                ],
              ),
            ),
            if (_booking.value.bookingAt == null)
              Container(
                width: 80,
                child: SizedBox.shrink(),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              ),
            if (_booking.value.bookingAt != null)
              Container(
                width: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        DateFormat('HH:mm', Get.locale.toString())
                            .format(_booking.value.bookingAt),
                        maxLines: 1,
                        style: Get.textTheme.bodyText2.merge(
                          TextStyle(
                              color: Get.theme.colorScheme.secondary,
                              height: 1.4),
                        ),
                        softWrap: false,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade),
                    Text(
                        DateFormat('dd', Get.locale.toString())
                            .format(_booking.value.bookingAt ?? ''),
                        maxLines: 1,
                        style: Get.textTheme.headline3.merge(
                          TextStyle(
                              color: Get.theme.colorScheme.secondary,
                              height: 1),
                        ),
                        softWrap: false,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade),
                    Text(
                        DateFormat('MMM', Get.locale.toString())
                            .format(_booking.value.bookingAt ?? ''),
                        maxLines: 1,
                        style: Get.textTheme.bodyText2.merge(
                          TextStyle(
                              color: Get.theme.colorScheme.secondary,
                              height: 1),
                        ),
                        softWrap: false,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              ),
          ],
        );
      }),
    );
  }

  Container buildContactProvider(Booking _booking) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: Ui.getBoxDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Contact Provider".tr, style: Get.textTheme.subtitle2),
                Text(_booking.eProvider?.phoneNumber ?? '',
                    style: Get.textTheme.caption),
              ],
            ),
          ),
          Wrap(
            spacing: 5,
            children: [
              MaterialButton(
                onPressed: () {
                  launch("tel:${_booking.eProvider?.phoneNumber ?? ''}");
                },
                height: 44,
                minWidth: 44,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                child: Icon(
                  Icons.phone_android_outlined,
                  color: Get.theme.colorScheme.secondary,
                ),
                elevation: 0,
              ),
              MaterialButton(
                onPressed: () {
                  controller.startChat();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                padding: EdgeInsets.zero,
                height: 44,
                minWidth: 44,
                child: Icon(
                  Icons.chat_outlined,
                  color: Get.theme.colorScheme.secondary,
                ),
                elevation: 0,
              ),
            ],
          )
        ],
      ),
    );
  }
}
