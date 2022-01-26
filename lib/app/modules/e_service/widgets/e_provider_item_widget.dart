import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services/app/routes/app_routes.dart';
import 'package:home_services/common/colors.dart';

import '../../../../common/ui.dart';
import '../../../models/e_provider_model.dart';

class EProviderItemWidget extends StatelessWidget {
  final EProvider provider;

  EProviderItemWidget({Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: 20,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(

            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: CachedNetworkImage(
                      height: 65,
                      width: 65,
                      fit: BoxFit.cover,
                      imageUrl: provider.firstImageThumb,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                        height: 65,
                        width: 65,
                      ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_outline),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 65,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Expanded(
                            child: Text(
                              provider.name,
                              overflow: TextOverflow.fade,

                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyText2.merge(
                                  TextStyle(color: Theme.of(context).hintColor)),
                            ),
                          ),
                          //SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(Icons.star,color: Colors.amber,),
                              Text(provider.rate.toString()),
                            ],
                          ),
                          SizedBox(height: 5),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.E_PROVIDER, arguments: {'eProvider': provider, 'heroTag': 'e_service_details'});
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                            color: defColor.withOpacity(.12),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: Offset(0,5.0)
                        ),],
                          color: defColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text('View Profile',
                            style: Get.theme.textTheme.caption
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
             Text(
                provider.description,
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 3,
              )
              ],
          ),
        ),
        // Text(
        //   review.review,
        //   style: Theme.of(context).textTheme.caption,
        //   overflow: TextOverflow.ellipsis,
        //   softWrap: false,
        //   maxLines: 3,
        // )
      ],
    );
  }
}
