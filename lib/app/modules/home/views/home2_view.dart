import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_services/common/colors.dart';
import 'package:home_services/common/underLineTextButton.dart';

import '../../../../common/ui.dart';
import '../../../models/slide_model.dart';
import '../../../providers/laravel_provider.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/address_widget.dart';
import '../../global_widgets/home_search_bar_widget.dart';
import '../../global_widgets/notifications_button_widget.dart';
import '../controllers/home_controller.dart';
import '../widgets/categories_carousel_widget.dart';
import '../widgets/featured_categories_widget.dart';
import '../widgets/recommended_carousel_widget.dart';
import '../widgets/slide_item_widget.dart';

class Home2View extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            Get.find<LaravelApiClient>().forceRefresh();
            await controller.refreshHome(showMessage: true);
            Get.find<LaravelApiClient>().unForceRefresh();
          },
          child: CustomScrollView(
            primary: true,
            shrinkWrap: false,
            slivers: <Widget>[
              SliverAppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Get.theme.brightness,
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 250,
                elevation: 0.5,
                floating: true,
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                title: AddressWidget(),
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.sort, color:Get.theme.colorScheme.background),
                  onPressed: () => {Scaffold.of(context).openDrawer()},
                ),
                actions: [NotificationsButtonWidget()],
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Obx(() {
                      return Stack(
                        alignment: controller.slider.isEmpty
                            ? AlignmentDirectional.center
                            : Ui.getAlignmentDirectional(controller.slider.elementAt(controller.currentSlide.value).textPosition),
                        children: <Widget>[

                          CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 7),
                              height: 360,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                controller.currentSlide.value = index;
                              },
                            ),
                            items: controller.slider.map((Slide slide) {
                              return SlideItemWidget(slide: slide);
                            }).toList(),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: controller.slider.map((Slide slide) {
                                return Container(
                                  width: 8,
                                  height: 8,
                                  margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 3.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: controller.currentSlide.value == controller.slider.indexOf(slide) ? Get.theme.colorScheme.background : Colors.grey.withOpacity(0.5)),
                                );
                              }).toList(),
                            ),
                          ),

                        ],
                      );
                    }),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Wrap(
                  children: [
                    SizedBox(width: double.infinity,height: 10,),
                    HomeSearchBarWidget(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(child: Text("Categories".tr, style: Get.textTheme.headline5)),
                          UnderLineTextButton(
                            onPressed:() {
                              Get.toNamed(Routes.CATEGORIES);
                            },
                            text: "View All",
                          ),
                        ],
                      ),
                    ),
                    CategoriesCarouselWidget(),
                    Container(
                      color: Get.theme.primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(child: Text("Recommended for you".tr, style: Get.textTheme.headline5)),
                          UnderLineTextButton(
                            onPressed:() {
                              Get.toNamed(Routes.CATEGORIES);
                            },
                            text: "View All",
                          ),

                        ],
                      ),
                    ),
                    RecommendedCarouselWidget(),
                    FeaturedCategoriesWidget(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
