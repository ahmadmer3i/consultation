// ignore_for_file: prefer_const_constructors
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/components.dart';
import 'package:consultation/view_model/messages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SeekerChatOpen extends StatefulWidget {
  final String consultId;
  final String providerId;
  final String seekerId;
  final bool isClosed;
  final String uid;
  const SeekerChatOpen({
    Key? key,
    this.isClosed = false,
    required this.uid,
    required this.consultId,
    required this.providerId,
    required this.seekerId,
  }) : super(key: key);

  @override
  _SeekerChatOpenState createState() => _SeekerChatOpenState();
}

class _SeekerChatOpenState extends State<SeekerChatOpen> {
  final messageController = TextEditingController();
  var rating = 0.0;
  @override

  //build screen
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        MessagesCubit.get(context)
            .getMessages(consultId: widget.consultId, messageId: widget.uid);
        return BlocConsumer<MessagesCubit, MessagesState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: MyAppBar(
                onPressed: !MessagesCubit.get(context).isClosing
                    ? () {
                        //build app bar
                        MessagesCubit.get(context).setIsClosing();
                      }
                    : () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Colors.white,
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.4, //media query ابعاد الجهاز اخذت ٤٠٪ من الشاشه
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ), //زوايا الكونتينر نفسه و اللون
                                child: Center(
                                  // new widget so i need child its under container
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    // اذا ابي فوق او تحت بعض استخدم كولم
                                    children: [
                                      //list collection of widgets
                                      Text("قيم تجربتك"),
                                      Directionality(
                                        textDirection: ui.TextDirection.ltr,
                                        child: SmoothStarRating(
                                          allowHalfRating: true, // 0.5 star
                                          onRated: (v) {
                                            MessagesCubit.get(context)
                                                .setRating(v);
                                          },
                                          starCount: 5,
                                          rating:
                                              MessagesCubit.get(context).rating,
                                          size: 40.0,
                                          isReadOnly: false,
                                          filledIconData: Icons.star_outlined,
                                          halfFilledIconData: Icons.star_half,
                                          color: Colors.amber,
                                          borderColor: Colors.amber,
                                          spacing: 0.0,
                                        ),
                                      ),
                                      !MessagesCubit.get(context).isLoading
                                          ? ElevatedButton(
                                              onPressed: () async {
                                                //future function we used async and await when the data is filled in firebase (ex:bad connection)
                                                // continue this
                                                await FirebaseFirestore.instance
                                                    .collection("provider")
                                                    .doc(widget.providerId)
                                                    .collection("ratings")
                                                    .doc()
                                                    .set(
                                                  {
                                                    "rating": MessagesCubit.get(
                                                            context)
                                                        .rating,
                                                  },
                                                ).then(
                                                  (value) {
                                                    MessagesCubit.get(context)
                                                        .calculateRating(
                                                      providerId:
                                                          widget.providerId,
                                                    );
                                                  },
                                                ).then(
                                                  (value) =>
                                                      MessagesCubit.get(context)
                                                          .endChat(
                                                              providerId: widget
                                                                  .providerId,
                                                              consultId: widget
                                                                  .consultId),
                                                );
                                                // ?= variable is optional may be null
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("إرسال"),
                                            )
                                          : CircularProgressIndicator(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      reverse: true,
                      controller: MessagesCubit.get(context).scroll,
                      itemCount: MessagesCubit.get(context).messages.length,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 2,
                      ),
                      itemBuilder: (context, index) {
                        var messages = MessagesCubit.get(context).messages;
                        if (messages[index].senderId == widget.seekerId) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 300),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFE0BE),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        child: Text(
                                          messages[index].message,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(height: 1),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          DateFormat.jm('ar').format(
                                            messages[index].dateTime.toDate(),
                                          ),
                                          textAlign: TextAlign.end,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(height: 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 300),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffF3F3F3),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      )),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        child: Text(
                                          messages[index].message,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(height: 1),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          DateFormat.jm('ar').format(
                                              messages[index]
                                                  .dateTime
                                                  .toDate()),
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(height: 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  !MessagesCubit.get(context).isClosing
                      ? Container(
                          color: Color(0xffFFE0BE),
                          height: 60,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_horiz),
                              ),
                              Expanded(
                                child: MyTextFieldDark(
                                  textController: messageController,
                                  backgroundColor: Colors.white,
                                  label: "",
                                  showLabel: false,
                                  radius: 30,
                                  iconButton: IconButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.attachment,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.camera_alt),
                              ),
                              IconButton(
                                onPressed: () {
                                  MessagesCubit.get(context).sendChat(
                                    messageId: widget.seekerId,
                                    consultId: widget.consultId,
                                    message: messageController.text,
                                    dateTime:
                                        Timestamp.fromDate(DateTime.now()),
                                    senderId: widget.seekerId,
                                    receiverId: widget.providerId,
                                  );
                                  messageController.clear();
                                },
                                icon: Icon(
                                  Icons.send,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
              bottomNavigationBar: MyBottomNavigationBar(),
            );
          },
        );
      },
    );
  }
}
