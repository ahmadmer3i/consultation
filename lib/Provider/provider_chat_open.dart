// ignore_for_file: prefer_const_constructors

import 'package:consultation/components.dart';
import 'package:flutter/material.dart';

class ProviderChatOpen extends StatefulWidget {
  final bool isClosed;
  const ProviderChatOpen({Key? key, this.isClosed = false}) : super(key: key);

  @override
  _ProviderChatOpenState createState() => _ProviderChatOpenState();
}

class _ProviderChatOpenState extends State<ProviderChatOpen> {
  bool? isclosed = false;

  @override
  void initState() {
    isclosed = widget.isClosed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onPressed: () {},
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
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
                              )),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                  margin: EdgeInsets.all(5),
                                  child: Text(
                                    "السلام عليكم",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(height: 1),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "12:06 مساءً",
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(height: 1),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
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
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.all(5),
                                  child: Text(
                                    "وعليكم السلام",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(height: 1),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "12:06 مساءً",
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(height: 1),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          !isclosed!
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
                      )),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.camera_alt),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.send,
                          )),
                    ],
                  ),
                )
              : Container()
        ],
      ),
      bottomNavigationBar: MyProviderBottomNavigationBar(),
    );
  }
}
