import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../common/ui.dart';
import '../controllers/categories_controller.dart';
import '../../../models/category_model.dart';


class SubCategoryView extends GetView<CategoriesController> {
  final Category category;

  SubCategoryView(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.name.tr,
          style: Get.textTheme.headline4.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_outlined, color: Get.theme.hintColor),
          onPressed: () => {Get.back()},
        ),
      ),
      body: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: category.subCategories.length,
        separatorBuilder: (context, index) {
          return SizedBox(height: 1);
        },
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: Ui.getBoxDecoration(
                border: Border.fromBorderSide(BorderSide.none),),
            child: Theme(
              data: Get.theme.copyWith(dividerColor: Colors.transparent),
              child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: new BoxDecoration(
                            color: category.subCategories[index].color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: (category.subCategories[index].image.url.toLowerCase().endsWith('.svg')
                              ? SvgPicture.network(
                            category.image.url,
                            color: category.subCategories[index].color,
                          )
                              : CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: category.subCategories[index].image.url,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error_outline),
                          )),
                        ),
                        SizedBox(width: 15  ),
                        Expanded(
                          child: Text(
                            category.subCategories[index].name,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: Get.textTheme.headline4.copyWith(fontSize: 14 , fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
          );
        },
      ),
    );
  }


}
