// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:consultation/provider/provider_chat.dart';
import 'package:consultation/provider/provider_dashboard.dart';
import 'package:consultation/provider/provider_profile.dart';
import 'package:consultation/provider/seeker_notification.dart';
import 'package:consultation/seeker/dashboard_seeker.dart';
import 'package:consultation/seeker/my_requests.dart';
import 'package:consultation/seeker/seeker_chat.dart';
import 'package:consultation/seeker/seeker_notification.dart';
import 'package:consultation/view_model/provider/provider_update_instant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

import 'Seeker/seeker_profile.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final IconButton? iconButton;
  final bool? isObscure;
  final String? Function(String?)? validator;
  final TextEditingController? textController;
  final Function(String)? onChanged;
  final Widget? suffixIcon;

  const MyTextField({
    Key? key,
    this.suffixIcon,
    required this.label,
    this.onChanged,
    this.iconButton,
    this.isObscure = false,
    this.validator,
    this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: isObscure!,
      validator: validator,
      controller: textController,
      style: TextStyle(
        color: Color(0xffFFE8D6),
        fontSize: 14,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        suffixIcon: suffixIcon,
        suffix: iconButton,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffFFE8D6),
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color(0xffFFE8D6),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color(0xffFFE8D6),
          ),
        ),
        hintText: label,
        hintStyle: TextStyle(color: Color(0xffFFE8D6).withAlpha(100)),
        labelText: label,
        labelStyle: TextStyle(color: Color(0xffFFE8D6)),
        prefixText: ' ',
      ),
    );
  }
}

class MyTextFieldDark extends StatefulWidget {
  final String label;
  final bool showHint;
  final bool showLabel;
  final Color? backgroundColor;
  final IconButton? iconButton;
  final Widget? suffix;
  final bool? isObscure;
  final int minHeight;
  final int? maxLength;
  final int? maxLines;
  final double? radius;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? textController;
  final bool isReadOnly;
  final String? initialValue;
  const MyTextFieldDark({
    Key? key,
    this.initialValue,
    required this.label,
    this.isReadOnly = false,
    this.onChanged,
    this.suffixIcon,
    this.iconButton,
    this.isObscure = false,
    this.minHeight = 1,
    this.showHint = true,
    this.suffix,
    this.maxLength,
    this.radius,
    this.showLabel = true,
    this.backgroundColor,
    this.maxLines,
    this.textController,
    this.validator,
  }) : super(key: key);

  @override
  _MyTextFieldDarkState createState() => _MyTextFieldDarkState();
}

class _MyTextFieldDarkState extends State<MyTextFieldDark> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      readOnly: widget.isReadOnly,
      controller: widget.textController,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      obscureText: widget.isObscure!,
      validator: widget.validator,
      style: TextStyle(
        color: Color(0xff6B705C),
        fontSize: 14,
      ),
      minLines: widget.minHeight,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        suffix: widget.iconButton ?? widget.suffix,
        fillColor: widget.backgroundColor,
        filled: widget.backgroundColor != null ? true : false,
        focusedBorder: OutlineInputBorder(
            borderRadius: widget.radius == null
                ? BorderRadius.all(Radius.circular(4.0))
                : BorderRadius.all(Radius.circular(widget.radius!)),
            borderSide: BorderSide(color: Color(0xff6B705C), width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: widget.radius == null
                ? BorderRadius.all(Radius.circular(4.0))
                : BorderRadius.all(Radius.circular(widget.radius!)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        hintText: widget.showHint ? widget.label : null,
        hintStyle: TextStyle(color: Color(0xff6B705C).withAlpha(100)),
        labelText: widget.showLabel ? widget.label : null,
        labelStyle: TextStyle(color: Color(0xff6B705C)),
        suffixIcon: widget.suffixIcon,
        prefixText: ' ',
      ),
    );
  }
}

class CategoriesSelector extends StatefulWidget {
  final FormFieldValidator? validator;
  const CategoriesSelector({Key? key, this.validator}) : super(key: key);

  @override
  _CategoriesSelectorState createState() => _CategoriesSelectorState();
}

class _CategoriesSelectorState extends State<CategoriesSelector> {
  List<IconData> icons = [
    Icons.circle_outlined,
    Icons.circle_outlined,
    Icons.circle_outlined,
    Icons.circle_outlined,
    Icons.circle_outlined,
    Icons.circle_outlined,
    Icons.circle_outlined,
    Icons.circle_outlined,
    Icons.circle_outlined,
    Icons.circle_outlined,
    Icons.circle_outlined,
    Icons.circle_outlined,
  ];
  List<Color> selectedItemColors = [
    Color(0xff6B705C),
    Color(0xff6B705C),
    Color(0xff6B705C),
    Color(0xff6B705C),
    Color(0xff6B705C),
    Color(0xff6B705C),
    Color(0xff6B705C),
    Color(0xff6B705C),
    Color(0xff6B705C),
    Color(0xff6B705C),
    Color(0xff6B705C),
    Color(0xff6B705C),
  ];
  List<bool> checkedItems = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    List<String> list = [
      "تصميم غرافيك",
      "تكنولوجيا المعلومات",
      "إحصاء",
      "كيمياء",
      "اللغة و الترجمة",
      "تسويق",
      "تصميم غرافيك",
      "تكنولوجيا المعلومات",
      "إحصاء",
      "كيمياء",
      "اللغة و الترجمة",
      "تسويق"
    ];

    List chunk(List list, int chunkSize) {
      List chunks = [];
      int len = list.length;
      for (var i = 0; i < len; i += chunkSize) {
        int size = i + chunkSize;
        chunks.add(list.sublist(i, size > len ? len : size));
      }
      return chunks;
    }

    // List numbers = [1, 2, 3, 4, 5];

    // print(chunk(list, 4));

    return FormField(
      validator: widget.validator,
      builder: (FormFieldState<dynamic> field) {
        return SizedBox(
          height: 200,
          width: 500,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  chunk(list, 4).length,
                  (indexRow) {
                    List currentRow = chunk(list, 4).elementAt(indexRow);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        currentRow.length,
                        (indexCol) {
                          int itemIndex =
                              ((list.length / 3 - 1).toInt()) * indexRow +
                                  indexRow +
                                  indexCol; // Real index of list items
                          return GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  checkedItems[itemIndex] =
                                      !checkedItems[itemIndex]; //toggle
                                  if (checkedItems[itemIndex] == true) {
                                    icons[itemIndex] = Icons.check;
                                    selectedItems.add(list[itemIndex]);
                                    selectedItemColors[itemIndex] =
                                        Colors.amber;
                                  } else {
                                    icons[itemIndex] = Icons.circle_outlined;
                                    selectedItems.removeWhere((element) =>
                                        element == list[itemIndex]);
                                    selectedItemColors[itemIndex] =
                                        Color(0xff6B705C);
                                  }
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              margin: EdgeInsets.all(5),
                              height: 40,
                              child: Row(
                                children: [
                                  Icon(
                                    icons[((list.length / 3 - 1).toInt()) *
                                            indexRow +
                                        indexRow +
                                        indexCol],
                                    color: Colors.white,
                                  ),
                                  Text(
                                    currentRow.elementAt(indexCol),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: selectedItemColors[itemIndex],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  final bool autoLeading;

  @override
  final Size preferredSize;
  final VoidCallback? onPressed;

  MyAppBar({Key? key, this.autoLeading = true, this.onPressed})
      : preferredSize = Size.fromHeight(56.0),
        super(key: key);
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        widget.onPressed != null
            ? IconButton(
                onPressed: widget.onPressed,
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              )
            : Container()
      ],
      leading: widget.autoLeading
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ))
          : null,
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: Image.asset("Assets/Logo4.png"),
      backgroundColor: Color(0xff6B705C),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  final int? selectedIndex;

  const MyBottomNavigationBar({
    Key? key,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  List<Widget> screens = [
    SeekerProfile(),
    MyRequests(),
    SeekerChat(),
    SeekerNotification(),
    DashboardSeeker(username: currentUsername)
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        if (index == 4) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => DashboardSeeker(
                        username: currentUsername,
                      )),
              (route) => false);
        } else if (index == 3) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SeekerChat()),
              (route) => false);
        } else if (index == 2) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SeekerNotification()),
              (route) => false);
        } else if (index == 1) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyRequests()),
            (route) => false,
          );
        } else if (index == 0) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SeekerProfile()),
            (route) => false,
          );
        }
      },
      currentIndex: widget.selectedIndex!,
      backgroundColor: Color(0xff6B705C),
      unselectedIconTheme: IconThemeData(color: Color(0xffA6A68E)),
      selectedIconTheme: IconThemeData(color: Color(0xffFFE8D6)),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 20,
            ),
            label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.list_outlined), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ""),
      ],
    );
  }
}

class MyProviderBottomNavigationBar extends StatefulWidget {
  final int? selectedIndex;
  const MyProviderBottomNavigationBar({Key? key, this.selectedIndex = 0})
      : super(key: key);

  @override
  _MyProviderBottomNavigationBarState createState() =>
      _MyProviderBottomNavigationBarState();
}

class _MyProviderBottomNavigationBarState
    extends State<MyProviderBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        if (index == 3) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ProviderDashboard()),
              (route) => false);
        } else if (index == 2) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ProviderChat()),
              (route) => false);
        } else if (index == 1) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ProviderNotification()),
              (route) => false);
        } else if (index == 0) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ProviderProfile()),
              (route) => false);
        }
      },
      currentIndex: widget.selectedIndex!,
      backgroundColor: Color(0xff6B705C),
      unselectedIconTheme: IconThemeData(color: Color(0xffA6A68E)),
      selectedIconTheme: IconThemeData(color: Color(0xffFFE8D6)),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 20,
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ""),
      ],
    );
  }
}

class MyBottomSheet extends StatefulWidget {
  final double price;
  final VoidCallback onPressed;
  const MyBottomSheet({
    Key? key,
    required this.price,
    required this.onPressed,
  }) : super(key: key);

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  int selectedMethod = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
      child: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                "تأكيد الدفع",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Color(0xffCB997E), fontWeight: FontWeight.w700),
              )),
          Align(
              alignment: Alignment.center,
              child: Text(
                "إجمالي المبلغ",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
              )),
          Align(
            alignment: Alignment.center,
            child: Text(
              "${widget.price}",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "ریال",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.black, height: 1, fontWeight: FontWeight.w700),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "جنس*",
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Color(0xffFFE8D6),
                  ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: DropdownButton(
              hint: Text(
                "جنس*",
                style: TextStyle(
                  color: Color(0xffFFE8D6),
                  decoration: TextDecoration.none,
                ),
              ),
              onChanged: (int? value) {
                setState(
                  () {
                    selectedMethod = value!;
                    selectedPaymentMethod = value;
                  },
                );
              },
              focusColor: Colors.white,
              style: TextStyle(color: Colors.white),
              value: selectedMethod,
              dropdownColor: Colors.white,
              isExpanded: true,
              items: [
                DropdownMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Image.asset(
                          "Assets/applePay.png",
                          width: 50,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Apple Pay",
                              style: Theme.of(context).textTheme.bodyText2,
                            ))
                      ],
                    )),
                DropdownMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Image.asset(
                        "Assets/stcPay.png",
                        width: 50,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "STC Pay",
                            style: Theme.of(context).textTheme.bodyText2,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: widget.onPressed,
            child: Text(
              "دفع",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyOfferBottomSheet extends StatefulWidget {
  final String docId;
  final ProviderConsult data;
  const MyOfferBottomSheet({Key? key, required this.docId, required this.data})
      : super(key: key);

  @override
  _MyOfferBottomSheetState createState() => _MyOfferBottomSheetState();
}

class _MyOfferBottomSheetState extends State<MyOfferBottomSheet> {
  final priceController = TextEditingController();
  int selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "تأكيد الدفع",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Color(0xffCB997E),
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            MyTextFieldDark(
              textController: priceController,
              label: "الرجاء تحديد السعر",
              iconButton: IconButton(
                icon: Text("ریال"),
                onPressed: () {},
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                updateInstantStatus(
                  docId: widget.docId,
                  data: widget.data,
                  price: double.parse(priceController.text.toString()),
                  isSent: true,
                );
                Navigator.pop(context);
              },
              child: Text(
                "دفع",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReportStatus extends StatefulWidget {
  final int selectedIndex;
  const ReportStatus({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  ReportStatusState createState() => ReportStatusState();
}

class ReportStatusState extends State<ReportStatus> {
  List status = ["انتظار", "قید المراجعۃ", "منتھیۃ"];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
              child: Container(
                  color: widget.selectedIndex == 0 ? Color(0xffCB997E) : null,
                  child: Center(
                      child: Text(
                    "انتظار",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: widget.selectedIndex == 0
                            ? Color(0xffFFE8D6)
                            : Color(0xff6B705C)),
                  )))),
          Expanded(
              child: Container(
                  color: widget.selectedIndex == 1 ? Color(0xffCB997E) : null,
                  child: Center(
                      child: Text(
                    "قید المراجعۃ",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: widget.selectedIndex == 1
                            ? Color(0xffFFE8D6)
                            : Color(0xff6B705C)),
                  )))),
          Expanded(
            child: Container(
              color: widget.selectedIndex == 2 ? Color(0xffCB997E) : null,
              child: Center(
                child: Text(
                  "منتھیۃ",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: widget.selectedIndex == 2
                          ? Color(0xffFFE8D6)
                          : Color(0xff6B705C)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingEditor extends StatefulWidget {
  double rating;
  RatingEditor({Key? key, this.rating = 0}) : super(key: key);

  @override
  _RatingEditorState createState() => _RatingEditorState();
}

class _RatingEditorState extends State<RatingEditor> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: StarRating(
        onRatingChanged: (value) {
          setState(() {
            widget.rating = value;
          });
        },
        rating: widget.rating,
        size: 40,
        borderColor: Color(0xff6B705C),
        color: Color(0xff6B705C),
      ),
    );
  }
}
