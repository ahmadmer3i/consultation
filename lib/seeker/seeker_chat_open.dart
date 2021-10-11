// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/Provider/provider_chat.dart';
import 'package:consultation/components.dart';
import 'package:consultation/view_model/messages_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool? isClosed = false;
  final messageController = TextEditingController();
  var rating = 0.0;
  @override
  void initState() {
    isClosed = widget.isClosed;

    super.initState();
  }

  @override

  //build screen
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessagesCubit(),
      child: Builder(
        builder: (context) {
          MessagesCubit.get(context)
              .getMessages(consultId: widget.consultId, messageId: widget.uid);
          print(widget.uid);
          return BlocConsumer<MessagesCubit, MessagesState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                appBar: MyAppBar(
                  onPressed: !isClosed!
                      ? () {
                          setState(
                            () {
                              //build app bar
                              isClosed = true;
                            },
                          );
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ), //زوايا الكونتينر نفسه و اللون
                                  child: Center(
                                    // new widget so i need child its under container
                                    child: Column(
                                      // اذا ابي فوق او تحت بعض استخدم كولم
                                      children: [
                                        //list collection of widgets
                                        SmoothStarRating(
                                          allowHalfRating: true, // 0.5 star
                                          onRated: (v) {
                                            setState(
                                              () {
                                                // go back to build widget each time the rate of stars change
                                                rating = v;
                                              },
                                            );
                                          },
                                          starCount: 5,
                                          rating: rating,
                                          size: 40.0,
                                          isReadOnly: false,
                                          filledIconData: Icons.star_outlined,
                                          halfFilledIconData: Icons.star_half,
                                          color: Colors.yellow,
                                          borderColor: Colors.yellow,
                                          spacing: 0.0,
                                        ),
                                        ElevatedButton(
                                            onPressed: () async {
                                              //future function we used async and await when the data is filled in firebase (ex:bad connection)

                                              // continue this

                                              await FirebaseFirestore.instance
                                                  .collection("provider")
                                                  .doc(widget.uid)
                                                  .collection("ratings")
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .set(
                                                {"rating": rating},
                                              ); // ?= variable is optional may be null
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProviderChat()),
                                                      (route) => false);
                                            },
                                            child: Text("إرسال"))
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
                              padding: EdgeInsets.all(10),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                              padding: EdgeInsets.all(10),
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
                    !isClosed!
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
                                    print('pressed');
                                    print(widget.seekerId);
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
      ),
    );
  }
}
