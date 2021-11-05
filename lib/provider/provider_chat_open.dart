// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/components.dart';
import 'package:consultation/view_model/messages_cubit.dart';
import 'package:consultation/widgets/report_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProviderChatOpen extends StatefulWidget {
  final String collectionName;
  final bool isClosed;
  final String providerId;
  final String seekerId;
  final String consultId;
  const ProviderChatOpen(
      {Key? key,
      this.isClosed = false,
      required this.collectionName,
      required this.providerId,
      required this.seekerId,
      required this.consultId})
      : super(key: key);

  @override
  _ProviderChatOpenState createState() => _ProviderChatOpenState();
}

class _ProviderChatOpenState extends State<ProviderChatOpen> {
  bool? isClosed = false;
  final messageController = TextEditingController();

  @override
  void initState() {
    isClosed = widget.isClosed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onPressed: () {},
      ),
      body: BlocProvider(
        create: (context) => MessagesCubit(),
        child: Builder(
          builder: (context) {
            MessagesCubit.get(context).getMessages(
                collectionName: "consults",
                consultId: widget.consultId,
                messageId: widget.seekerId);
            return BlocConsumer<MessagesCubit, MessagesState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        reverse: true,
                        controller: MessagesCubit.get(context).scroll,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 3,
                        ),
                        itemCount: MessagesCubit.get(context).messages.length,
                        itemBuilder: (context, index) {
                          var messages = MessagesCubit.get(context).messages;
                          if (messages[index].senderId == widget.providerId) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
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
                                                messages[index]
                                                    .dateTime
                                                    .toDate()),
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
                                  horizontal: 5, vertical: 2),
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
                                      ),
                                    ),
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
                                  onPressed: () {
                                    reportModalSheet(context,
                                        sender: "providerId",
                                        receiver: "seekerId",
                                        reportCollection: "providerReports",
                                        userId: widget.seekerId);
                                  },
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
                                      collectionName: "consults",
                                      messageId: widget.seekerId,
                                      consultId: widget.consultId,
                                      message: messageController.text,
                                      dateTime:
                                          Timestamp.fromDate(DateTime.now()),
                                      senderId: widget.providerId,
                                      receiverId: widget.seekerId,
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
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: MyProviderBottomNavigationBar(),
    );
  }
}
