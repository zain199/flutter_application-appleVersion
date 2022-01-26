import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_services/common/colors.dart';

import '../../../routes/app_routes.dart';
import '../controllers/home_controller.dart';

class CategoriesCarouselWidget extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(bottom: 15),
      child: Obx(() {
        return ListView.builder(
            primary: false,
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (_, index) {
              var _category = controller.categories.elementAt(index);
              paddingSymmetric(horizontal: 10);
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.CATEGORY, arguments: _category);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 40,
                  width: 120,

                  decoration: BoxDecoration(

                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(

                            color: _category.color.withOpacity(.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: (_category.image.url.toLowerCase().endsWith('.svg')
                                ? SvgPicture.network(
                                    _category.image.url,
                                    color: _category.color,
                                    height: 30,
                                    width: 30,
                                  )
                                : CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: 30,
                                    width: 30,
                                    imageUrl: _category.image.url,

                                    placeholder: (context, url) => Image.asset(
                                      'assets/img/loading.gif',
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, url, error) => Icon(Icons.error_outline),
                                  )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _category.name,
                          maxLines: 2,
                          style: Get.textTheme.bodyText2.merge(TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
