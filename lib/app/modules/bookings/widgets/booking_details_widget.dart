import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../controllers/booking_controller.dart';

class BookingDetailsWidget extends GetView<BookingController> {
  final String name ;
  final Widget value ;
  const BookingDetailsWidget({
    Key key,
    this.name,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(name,style: Get.theme.textTheme.caption,),
          Spacer(),
          value,
        ],
      ),
    );
  }
}
