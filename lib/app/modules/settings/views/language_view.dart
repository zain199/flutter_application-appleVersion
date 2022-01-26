import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_services/app/modules/global_widgets/search_bar_widget.dart';

import '../../../../common/ui.dart';
import '../../../services/translation_service.dart';
import '../controllers/language_controller.dart';

class LanguageView extends GetView<LanguageController> {
  final bool hideAppBar;


  LanguageView({this.hideAppBar = false});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: hideAppBar
            ? null
            : AppBar(
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Get.theme.colorScheme.onBackground ,))
          ],
                title: Text(
                  "Languages".tr,
                  style: context.textTheme.headline4.copyWith(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back, color: Get.theme.hintColor),
                  onPressed: () => Get.back(),
                ),
                elevation: 0,
              ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: Ui.getBoxDecoration().copyWith(
            boxShadow: [BoxShadow()],
          ),
          child: ExpansionTile(
            title: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('assets/flags/'+Get.locale.languageCode+'.png'),

                  ),
                ),
                SizedBox(width: 10,),
                Text(Get.locale.toString().tr,style: Get.theme.textTheme.bodyText2,),
              ],
            ),
            children: [

              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    color: Get.theme.scaffoldBackgroundColor,
                    height: 430,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: Get.width,
                      height: 410,
                      color: Get.theme.primaryColor,
                      child: Column(
                        children: [
                          Container(
                            child: SearchBarWidget(),
                          ),
                          Column(
                                children: List.generate(TranslationService.languages.length, (index) {
                                  var _lang = TranslationService.languages.elementAt(index);
                                  return RadioListTile(
                                    value: _lang,
                                    groupValue: Get.locale.toString(),
                                    onChanged: (value) {
                                      controller.updateLocale(value);
                                    },
                                    title: Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                         clipBehavior:  Clip.antiAliasWithSaveLayer,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(15))
                                          ),
                                          child: Image.asset('assets/flags/'+_lang.split("_").first+'.png'),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(_lang.tr, style: Get.textTheme.bodyText2),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
