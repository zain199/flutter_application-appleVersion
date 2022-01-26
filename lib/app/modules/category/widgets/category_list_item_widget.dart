import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../../routes/app_routes.dart';

class CategoryListItemWidget extends StatelessWidget {
  final Category category;
  final String heroTag;
  final bool expanded;

  CategoryListItemWidget({Key key, this.category, this.heroTag, this.expanded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),

      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.fromBorderSide(BorderSide.none),

      ),


      child:
        ExpansionTile(

          initiallyExpanded: this.expanded,
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          title: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Get.theme.colorScheme.secondary.withOpacity(0.08),
              onTap: () {
                Get.toNamed(Routes.CATEGORY, arguments: category);
                //Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: '0', param: market.id, heroTag: heroTag));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: (category.image.url.toLowerCase().endsWith('.svg')
                        ? SvgPicture.network(
                            category.image.url,
                            color: category.color,
                            height: 100,
                          )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            color: category.color.withOpacity(.3),
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: category.image.url,
                                //color: category.color,
                                placeholder: (context, url) => Image.asset(
                                  'assets/img/loading.gif',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error_outline),
                              ),
                          ),
                        )),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      category.name,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: Get.textTheme.bodyText2,
                    ),
                  ),
                  Text('( '+category.subCategories.length.toString()+' )',style: Get.theme.textTheme.caption.copyWith(),)
                  // TODO get service for each category
                  // Text(
                  //   "(" + category.services.length.toString() + ")",
                  //   overflow: TextOverflow.fade,
                  //   softWrap: false,
                  //   style: Get.textTheme.caption,
                  // ),
                ],
              )),
          children: [
            Container(
              width: Get.width,
            color: Get.theme.scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            height: 150,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(category.subCategories?.length ?? 0, (index) {
              var _category = category.subCategories.elementAt(index);
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.CATEGORY, arguments: _category);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  width: 120,
                  height: 120,
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 20,
                    top: 10,

                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (_category.image.url.toLowerCase().endsWith('.svg')
                          ? SvgPicture.network(
                        _category.image.url,
                        color: category.color,
                        height: 100,
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          color: _category.color.withOpacity(.3),
                          height: 50,
                          width: 50,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: _category.image.url,
                            //color: category.color,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error_outline),
                          ),
                        ),
                      )),
                      SizedBox(height: 20,),
                      Text(_category.name,maxLines: 2,overflow: TextOverflow.fade,),
                    ],
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                //   child: Text(_category.name, style: Get.textTheme.bodyText1),
                //   decoration: BoxDecoration(
                //     color: Get.theme.scaffoldBackgroundColor.withOpacity(0.2),
                //     border: Border(top: BorderSide(color: Get.theme.scaffoldBackgroundColor.withOpacity(0.3))
                //       //color: Get.theme.focusColor.withOpacity(0.2),
                //     ),
                //   ),
                // ),
              );
            }),
              ),
            ),
          )
          ]
        ),

    );
  }


}
