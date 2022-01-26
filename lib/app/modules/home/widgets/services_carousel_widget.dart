import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services/common/colors.dart';

import '../../../../common/ui.dart';
import '../../../models/e_service_model.dart';
import '../../../routes/app_routes.dart';

class ServicesCarouselWidget extends StatelessWidget {
  final List<EService> services;

  const ServicesCarouselWidget({Key key, List<EService> this.services})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
          padding: EdgeInsets.only(bottom: 10),
          primary: false,
          shrinkWrap: false,
          scrollDirection: Axis.horizontal,
          itemCount: services.length,
          itemBuilder: (_, index) {
            var _service = services.elementAt(index);
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.E_SERVICE, arguments: {
                  'eService': _service,
                  'heroTag': 'services_carousel'
                });
              },
              child: Container(
                width: Get.size.width - 15,
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Get.theme.primaryColor),
                child: Row(
                  children: [
                    // this is the image
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        imageUrl: _service.firstImageUrl,
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150,
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error_outline),
                      ),
                    ),

                    //this is the body
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              _service.name,
                              maxLines: 1,
                              style: Get.textTheme.bodyText2
                                  .merge(TextStyle(color: Get.theme.hintColor)),
                            ),
                            SizedBox(height: 10),
                            Ui.getPrice(
                              _service.price,
                              style: Get.textTheme.bodyText2.merge(TextStyle(
                                  color: Get.theme.colorScheme.secondary)),
                              unit: _service.getUnit,
                            ),
                            Wrap(
                              spacing: 5,
                              alignment: WrapAlignment.spaceBetween,
                              direction: Axis.horizontal,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        Text(_service.rate.toString())
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        boxShadow:[
                                          BoxShadow(
                                              color: defColor.withOpacity(.12),
                                              blurRadius: 1,
                                              spreadRadius: 1,
                                              offset: Offset(0,5.0)
                                          )],
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.E_SERVICE,
                                              arguments: {
                                                'eService': _service,
                                                'heroTag': 'services_carousel'
                                              });
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              color: Get.theme.colorScheme.primary,

                                          ),
                                          child: Center(
                                            child: Text(
                                              'Book Now',
                                              style: Get.theme.textTheme.caption.copyWith(color: Colors.white)

                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
