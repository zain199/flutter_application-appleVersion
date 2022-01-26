import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/icon_broken.dart';

import '../../../models/chat_model.dart';
import '../../../models/media_model.dart';
import '../../../models/message_model.dart';
import '../../../models/user_model.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../controllers/messages_controller.dart';
import '../widgets/chat_message_item_widget.dart';

// ignore: must_be_immutable
class ChatsView extends GetView<MessagesController> {
  final _myListKey = GlobalKey<AnimatedListState>();
  bool isKeyboardVisible = false;
  Widget chatList() {
    return Obx(
      () {
        if (controller.chats.isEmpty) {
          return CircularLoadingWidget(
            height: Get.height,
            onCompleteText: "Type a message to start chat!".tr,
          );
        } else {
          return ListView.builder(
              key: _myListKey,
              reverse: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              itemCount: controller.chats.length,
              shrinkWrap: false,
              primary: true,
              itemBuilder: (context, index) {
                Chat _chat = controller.chats.elementAt(index);
                _chat.user = controller.message.value.users.firstWhere(
                    (_user) => _user.id == _chat.userId,
                    orElse: () => new User(name: "-", avatar: new Media()));
                return ChatMessageItem(
                  chat: _chat,
                );
              });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.message.value = Get.arguments as Message;
    if (controller.message.value.id != null) {
      controller.listenForChats();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Get.theme.colorScheme.onBackground,
              ),
          ),
          SizedBox(width: 8,)
        ],
        centerTitle: true,
        leading: new IconButton(
            icon:
                new Icon(Icons.arrow_back_outlined, color: Get.theme.hintColor),
            onPressed: () async {
              controller.message.value = new Message([]);
              controller.chats.clear();
              await controller.refreshMessages();
              Get.back();
            }),
        automaticallyImplyLeading: false,
        title: Obx(() {
          return Text(
            controller.message.value.name,
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: Get.textTheme.headline4
                .copyWith(fontWeight: FontWeight.bold),
          );
        }),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: chatList(),
          ),
          Obx(() {
            if (controller.uploading.isTrue)
              return Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: CircularProgressIndicator(),
              );
            else
              return SizedBox();
          }),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.10),
                      offset: Offset(0, -4),
                      blurRadius: 10)
                ],
              ),
              child: Row(
                children: [
                  // Wrap(
                  //   children: [
                  //     SizedBox(width: 10),
                  //     IconButton(
                  //       padding: EdgeInsets.zero,
                  //       onPressed: () async {
                  //         var imageUrl =
                  //             await controller.getImage(ImageSource.gallery);
                  //         if (imageUrl != null && imageUrl.trim() != '') {
                  //           await controller.addMessage(
                  //               controller.message.value, imageUrl);
                  //         }
                  //         Timer(Duration(milliseconds: 100), () {
                  //           controller.chatTextController.clear();
                  //         });
                  //       },
                  //       icon: Icon(
                  //         Icons.photo_outlined,
                  //         color: Get.theme.colorScheme.secondary,
                  //         size: 30,
                  //       ),
                  //     ),
                  //     IconButton(
                  //       padding: EdgeInsets.zero,
                  //       onPressed: () async {
                  //         var imageUrl =
                  //             await controller.getImage(ImageSource.camera);
                  //         if (imageUrl != null && imageUrl.trim() != '') {
                  //           await controller.addMessage(
                  //               controller.message.value, imageUrl);
                  //         }
                  //         Timer(Duration(milliseconds: 100), () {
                  //           controller.chatTextController.clear();
                  //         });
                  //       },
                  //       icon: Icon(
                  //         Icons.camera_alt_outlined,
                  //         color: Get.theme.colorScheme.secondary,
                  //         size: 30,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Expanded(
                    child: TextField(
                      controller: controller.chatTextController,
                      style: Get.textTheme.bodyText1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Type Something...".tr,
                        hintStyle: Get.textTheme.caption.copyWith(fontSize: 14),
                        suffixIcon: IconButton(
                          padding: EdgeInsetsDirectional.only(end: 20, start: 10),
                          onPressed: () async{

                          },
                          icon: Icon(
                            Icons.emoji_emotions_outlined,
                            color: Get.theme.colorScheme.onBackground,
                            size: 20,
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Spacer(),
                        //     IconButton(
                        //       padding: EdgeInsetsDirectional.only(end: 20, start: 10),
                        //       onPressed: () {
                        //         controller.addMessage(controller.message.value,
                        //             controller.chatTextController.text);
                        //         Timer(Duration(milliseconds: 100), () {
                        //           controller.chatTextController.clear();
                        //         });
                        //       },
                        //       icon: Icon(
                        //         Icons.emoji_emotions_outlined,
                        //         color: Get.theme.colorScheme.onBackground,
                        //         size: 20,
                        //       ),
                        //     ),
                        //
                        //     IconButton(
                        //       padding: EdgeInsetsDirectional.only(end: 20, start: 10),
                        //       onPressed: () {
                        //         controller.addMessage(controller.message.value,
                        //             controller.chatTextController.text);
                        //         Timer(Duration(milliseconds: 100), () {
                        //           controller.chatTextController.clear();
                        //         });
                        //       },
                        //       icon: Icon(
                        //         IconBroken.Send,
                        //         color: Get.theme.colorScheme.onBackground,
                        //         size: 20,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        border: UnderlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),

                  IconButton(onPressed: (){
                    controller.addMessage(controller.message.value,
                        controller.chatTextController.text);
                    Timer(Duration(milliseconds: 100), () {
                      controller.chatTextController.clear();
                    });
                  }, icon: Icon(IconBroken.Send , size: 20,))
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
