import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:home_services/common/colors.dart';
import 'package:home_services/common/underLineTextButton.dart';

import '../../../../common/ui.dart';
import '../../../models/e_service_model.dart';
import '../../../models/media_model.dart';
import '../../../providers/laravel_provider.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../controllers/e_service_controller.dart';
import '../widgets/e_provider_item_widget.dart';
import '../widgets/e_service_til_widget.dart';
import '../widgets/e_service_title_bar_widget.dart';
import '../widgets/option_group_item_widget.dart';
import '../widgets/review_item_widget.dart';

class EServiceView extends GetView<EServiceController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var _eService = controller.eService.value;
      if (!_eService.hasData) {
        return Scaffold(
          body: CircularLoadingWidget(height: Get.height),
        );
      } else {
        return Scaffold(
          bottomNavigationBar: buildBottomWidget(_eService),
          body: RefreshIndicator(
              onRefresh: () async {
                Get.find<LaravelApiClient>().forceRefresh();
                controller.refreshEService(showMessage: true);
                Get.find<LaravelApiClient>().unForceRefresh();
              },
              child: CustomScrollView(
                primary: true,
                shrinkWrap: false,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    expandedHeight: 359,
                    elevation: 0,
                    floating: true,
                    iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    leading: new IconButton(
                      icon: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                            color: Get.theme.primaryColor.withOpacity(0.5),
                            blurRadius: 20,
                          ),
                        ]),
                        child: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
                      ),
                      onPressed: () => {Get.back()},
                    ),
                    actions: [
                      new IconButton(
                        icon: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                              color: Get.theme.primaryColor.withOpacity(0.5),
                              blurRadius: 20,
                            ),
                          ]),
                          child: (_eService?.isFavorite ?? false) ? Icon(Icons.favorite, color: Colors.redAccent) : Icon(Icons.favorite_outline, color: Get.theme.hintColor),
                        ),
                        onPressed: () {
                          if (!Get.find<AuthService>().isAuth) {
                            Get.toNamed(Routes.LOGIN);
                          } else {
                            if (_eService?.isFavorite ?? false) {
                              controller.removeFromFavorite();
                            } else {
                              controller.addToFavorite();
                            }
                          }
                        },
                      ).marginSymmetric(horizontal: 10),
                    ],

                    // cover on the top image with indicator
                    flexibleSpace: Container(
                      height: 420,
                      clipBehavior:Clip.antiAliasWithSaveLayer ,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                        color:Get.theme.primaryColor //Get.theme.ye
                      ),
                      child: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Obx(() {
                          return Column(
                            children: [
                              //cover image an smoither
                              Container(
                                height: 250,
                                clipBehavior:Clip.antiAliasWithSaveLayer ,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(10)),
                                ),
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  children: <Widget>[
                                    // caroisal image
                                    Container(child: buildCarouselSlider(_eService),),
                                    // smoth indicator
                                    buildCarouselBullets(_eService),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              // title of service
                              Container(
                                child: buildEServiceTitleBarWidget(_eService),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                              ),
                              SizedBox(height: 30,)
                            ],
                          );
                        }),
                      ),
                    )
                  ),

                  // WelcomeWidget(),
                  SliverToBoxAdapter(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //************************* Desciption part ***********\\
                        EServiceTilWidget(
                          title: Text("Description".tr, style: Get.textTheme.subtitle2),
                          content: Text(_eService.description, style: Get.textTheme.caption.copyWith(fontSize: 15,),),
                        ),
                        // buildDuration(_eService),
                        //buildOptions(),
                        //************* the serviecprovider ***************//
                        buildServiceProvider(_eService),
                        // if (_eService.images.isNotEmpty)
                        //   EServiceTilWidget(
                        //     horizontalPadding: 0,
                        //     title: Text("Galleries".tr, style: Get.textTheme.subtitle2).paddingSymmetric(horizontal: 20),
                        //     content: Container(
                        //       height: 120,
                        //       child: ListView.builder(
                        //           primary: false,
                        //           shrinkWrap: false,
                        //           scrollDirection: Axis.horizontal,
                        //           itemCount: _eService.images.length,
                        //           itemBuilder: (_, index) {
                        //             var _media = _eService.images.elementAt(index);
                        //             return InkWell(
                        //               onTap: () {
                        //                 Get.toNamed(Routes.GALLERY, arguments: {'media': _eService.images, 'current': _media, 'heroTag': 'e_services_galleries'});
                        //               },
                        //               child: Container(
                        //                 width: 100,
                        //                 height: 100,
                        //                 margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0, top: 10, bottom: 10),
                        //                 child: Stack(
                        //                   alignment: AlignmentDirectional.topStart,
                        //                   children: [
                        //                     Hero(
                        //                       tag: 'e_services_galleries' + (_media?.id ?? ''),
                        //                       child: ClipRRect(
                        //                         borderRadius: BorderRadius.all(Radius.circular(10)),
                        //                         child: CachedNetworkImage(
                        //                           height: 100,
                        //                           width: double.infinity,
                        //                           fit: BoxFit.cover,
                        //                           imageUrl: _media.thumb,
                        //                           placeholder: (context, url) => Image.asset(
                        //                             'assets/img/loading.gif',
                        //                             fit: BoxFit.cover,
                        //                             width: double.infinity,
                        //                             height: 100,
                        //                           ),
                        //                           errorWidget: (context, url, error) => Icon(Icons.error_outline),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     Padding(
                        //                       padding: const EdgeInsetsDirectional.only(start: 12, top: 8),
                        //                       child: Text(
                        //                         _media.name ?? '',
                        //                         maxLines: 2,
                        //                         style: Get.textTheme.bodyText2.merge(TextStyle(
                        //                           color: Get.theme.primaryColor,
                        //                           shadows: <Shadow>[
                        //                             Shadow(
                        //                               offset: Offset(0, 1),
                        //                               blurRadius: 6.0,
                        //                               color: Get.theme.hintColor.withOpacity(0.6),
                        //                             ),
                        //                           ],
                        //                         )),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             );
                        //           }),
                        //     ),
                        //     actions: [
                        //       // TODO View all galleries
                        //     ],
                        //   ),

                        //************* the reveiwing ***************//

                        //************* the Reviews & Ratings part ***************//
                        EServiceTilWidget(
                          title: Row(
                            children: [
                              Text("Reviews & Ratings".tr, style: Get.textTheme.subtitle2),
                              Spacer(),
                              UnderLineTextButton(text: 'View All', onPressed: (){})
                            ],
                          ),
                          content: Column(
                            children: [
                              //************ ratings stars body ******\\
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(

                                            children: [
                                              Text(_eService.rate.toString(), style: Get.textTheme.headline4.copyWith(fontWeight: FontWeight.bold)),
                                              Text('/5', style: Get.textTheme.caption.copyWith(fontWeight: FontWeight.bold,fontSize: 15)),

                                            ],
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                          ),
                                          Spacer(),
                                          Text(
                                            "Based on "+_eService.totalReviews.toString()+" Reviews",
                                            style: Get.textTheme.caption.copyWith(fontSize: 12),
                                          ).paddingOnly(top: 10),
                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      ),
                                    ),
                                    Wrap(
                                      alignment: WrapAlignment.end,
                                      children: Ui.getStarsList(_eService.rate, size: 32),
                                    ),

                                  ],
                                ),
                                height: 75,
                                width: double.infinity,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Get.theme.primaryColor,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Obx(() {
                                if (controller.reviews.isEmpty) {
                                  return CircularLoadingWidget(height: 100);
                                }
                                return ListView.separated(
                                  padding: EdgeInsets.all(0),
                                  itemBuilder: (context, index) {
                                    return ReviewItemWidget(review: controller.reviews.elementAt(index));
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 10,);
                                    return SizedBox(height: 30,);
                                  },
                                  itemCount: controller.reviews.length,
                                  primary: false,
                                  shrinkWrap: true,
                                );
                              }),
                            ],
                          ),
                          actions: [
                            // TODO view all reviews
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      }
    });
  }

  Widget buildOptions() {
    return Obx(() {
      if (controller.optionGroups.isEmpty) {
        return SizedBox(height: 0);
      }
      return EServiceTilWidget(
        horizontalPadding: 0,
        title: Text("Options".tr, style: Get.textTheme.subtitle2).paddingSymmetric(horizontal: 20),
        content: ListView.separated(
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return OptionGroupItemWidget(optionGroup: controller.optionGroups.elementAt(index));
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 6);
          },
          itemCount: controller.optionGroups.length,
          primary: false,
          shrinkWrap: true,
        ),
      );
    });
  }

  Container buildDuration(EService _eService) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: Ui.getBoxDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text("Duration".tr, style: Get.textTheme.subtitle2),
                Text("This service can take up to ".tr, style: Get.textTheme.bodyText1),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Text(_eService.duration, style: Get.textTheme.headline6),
        ],
      ),
    );
  }

  CarouselSlider buildCarouselSlider(EService _eService) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 7),
        height: 370,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {
          controller.currentSlide.value = index;
        },
      ),
      items: _eService.images.map((Media media) {
        return Builder(
          builder: (BuildContext context) {
            return Hero(
              tag: controller.heroTag.value + _eService.id,
              child: CachedNetworkImage(
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
                imageUrl: media.url,
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Container buildCarouselBullets(EService _eService) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _eService.images.map((Media media) {
          return Container(
            width: 10.0,
            height: 10.0,
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: controller.currentSlide.value == _eService.images.indexOf(media) ? Get.theme.hintColor : Get.theme.primaryColor.withOpacity(0.4)),
          );
        }).toList(),
      ),
    );
  }

  Widget buildEServiceTitleBarWidget(EService _eService) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _eService.name ?? '',
                  style: Get.textTheme.headline5.merge(TextStyle(height: 1.1)),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
              if (_eService.eProvider == null)
                Container(
                  child: Text("  .  .  .  ".tr,
                      maxLines: 1,
                      style: Get.textTheme.bodyText2.merge(
                        TextStyle(color: Colors.grey, height: 1.4, fontSize: 10),
                      ),
                      softWrap: false,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  margin: EdgeInsets.symmetric(vertical: 3),
                ),
              if (_eService.eProvider != null && _eService.eProvider.available)
                Container(
                  child: Text("Available".tr,
                      maxLines: 1,
                      style: Get.textTheme.bodyText2.merge(
                        TextStyle(color: Colors.green, height: 1.4, fontSize: 10),
                      ),
                      softWrap: false,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  margin: EdgeInsets.symmetric(vertical: 3),
                ),
              if (_eService.eProvider != null && !_eService.eProvider.available)
                Container(
                  child: Text("Offline".tr,
                      maxLines: 1,
                      style: Get.textTheme.bodyText2.merge(
                        TextStyle(color: Colors.grey, height: 1.4, fontSize: 10),
                      ),
                      softWrap: false,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  margin: EdgeInsets.symmetric(vertical: 3),
                ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Ui.getPrice(
                  _eService.price,
                  style: Get.textTheme.headline5.merge(TextStyle(color: Get.theme.colorScheme.secondary)),
                  unit: _eService.getUnit,
                ),
              ),

              Expanded(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.star,color: Colors.amber,size: 23,),
                    SizedBox(width: 3,),
                    Text(_eService.rate.toString()+' '),
                    Text("( "+_eService.totalReviews.toString()+" Review )",style: Get.theme.textTheme.caption,)
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 8,),
          buildCategories(_eService),
        ],
      ),
    );
  }

  Widget buildCategories(EService _eService) {
    return Container(
      width: Get.width,
      height: 30,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_eService.categories.length, (index) {
                  var _category = _eService.categories.elementAt(index);
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    child: Text(_category.name, style: Get.textTheme.bodyText1.merge(TextStyle(color: _category.color))),
                    decoration: BoxDecoration(
                        color: _category.color.withOpacity(0.2),
                        border: Border.all(
                          color: _category.color.withOpacity(0.1),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  );
                }) +
                List.generate(_eService.subCategories.length, (index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    child: Text(_eService.subCategories.elementAt(index).name, style: Get.textTheme.caption),
                    decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        border: Border.all(
                          color: Get.theme.focusColor.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget buildServiceProvider(EService _eService) {
    if (_eService?.eProvider?.hasData ?? false) {
      return GestureDetector(
        onTap: () {
          Get.toNamed(Routes.E_PROVIDER, arguments: {'eProvider': _eService.eProvider, 'heroTag': 'e_service_details'});
        },
        child: EServiceTilWidget(
          title: Text("Service Provider".tr, style: Get.textTheme.subtitle2),
          content: EProviderItemWidget(provider: _eService.eProvider),
          actions: [
            Text("View More".tr, style: Get.textTheme.subtitle1),
          ],
        ),
      );
    } else {
      return EServiceTilWidget(
        title: Text("Service Provider".tr, style: Get.textTheme.subtitle2),
        content: SizedBox(
          height: 60,
        ),
        actions: [],
      );
    }
  }

  Widget buildBottomWidget(EService _eService) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, -5)),
        ],
      ),
      child: Row(
        children: [
          if (_eService.priceUnit == 'fixed')
            Container(
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                textDirection: TextDirection.ltr,
                children: [
                  MaterialButton(
                    height: 24,
                    minWidth: 46,
                    onPressed: controller.decrementQuantity,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    color: Get.theme.colorScheme.secondary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(10))),
                    child: Icon(Icons.remove, color: Get.theme.primaryColor, size: 28),
                    elevation: 0,
                  ),
                  SizedBox(
                    width: 38,
                    child: Obx(() {
                      return Text(
                        controller.quantity.toString(),
                        textAlign: TextAlign.center,
                        style: Get.textTheme.subtitle2.merge(
                          TextStyle(color: Get.theme.colorScheme.secondary),
                        ),
                      );
                    }),
                  ),
                  MaterialButton(
                    onPressed: controller.incrementQuantity,
                    height: 24,
                    minWidth: 46,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    color: Get.theme.colorScheme.secondary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10))),
                    child: Icon(Icons.add, color: Get.theme.primaryColor, size: 28),
                    elevation: 0,
                  ),
                ],
              ),
            ),
          if (_eService.priceUnit == 'fixed') SizedBox(width: 10),
          Expanded(
            child: BlockButtonWidget(
                text: Container(
                  height: 24,
                  alignment: Alignment.center,
                  child: Text(
                    "Book This Service".tr,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headline6.merge(
                      TextStyle(color: Get.theme.primaryColor),
                    ),
                  ),
                ),
                color: Get.theme.colorScheme.secondary,
                onPressed: () {
                  Get.toNamed(Routes.BOOK_E_SERVICE, arguments: {'eService': _eService, 'options': controller.getCheckedOptions(), 'quantity': controller.quantity.value});
                }),
          ),
        ],
      ).paddingOnly(right: 20, left: 20),
    );
  }
}
