import 'package:consultation/Components.dart';
import 'package:consultation/view_model/profile_update_seeker/profile_update_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeekerProfileEdit extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  SeekerProfileEdit({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileUpdateCubit>(
      create: (context) => ProfileUpdateCubit()..getDate(),
      child: BlocConsumer<ProfileUpdateCubit, ProfileUpdateState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit =
              ProfileUpdateCubit.get(context); // object from the Cubit Class
          return Scaffold(
            appBar: MyAppBar(),
            body: Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "تحديث الملف",
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: const Color(0xffCB997E),
                                  ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: MyTextFieldDark(
                          validator: (value) {
                            if (cubit.nameController.text.length < 6) {
                              return "يرجى ادخال الاسم الصحيح";
                            }
                            return null;
                          },
                          textController: cubit.nameController,
                          label: "الاسم بالكامل*",
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: MyTextFieldDark(
                          validator: (value) {
                            RegExp regExp = RegExp(
                                "(?:[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])");
                            if (!regExp.hasMatch(cubit.emailController.text)) {
                              return "يرجى ادخال البريد الالكتروني بالشكل الصحيح";
                            }
                            return null;
                          },
                          textController: cubit.emailController,
                          label: "البريد الإلكتروني*",
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "جنس*",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.black,
                              ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: DropdownButton(
                          hint: const Text(
                            "جنس*",
                            style: TextStyle(
                              color: Color(0xffFFE8D6),
                              decoration: TextDecoration.none,
                            ),
                          ),
                          onChanged: (int? value) {
                            cubit.gender = value == 0 ? "M" : "F";
                            cubit.getGenderValue(value!);
                          },
                          focusColor: Colors.white,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          value: cubit.gender == "M" ? 0 : 1,
                          dropdownColor: Colors.white,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                "ذكر",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text(
                                "أنثى",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: MyTextFieldDark(
                          validator: (value) {
                            RegExp regExp = RegExp(
                                "^(?:(?:31(\\/|-|\\.)(?:0?[13578]|1[02]))\\1|(?:(?:29|30)(\\/|-|\\.)(?:0?[13-9]|1[0-2])\\2))(?:(?:1[6-9]|[2-9]\\d)?\\d{2})\$|^(?:29(\\/|-|\\.)0?2\\3(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))\$|^(?:0?[1-9]|1\\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\\4(?:(?:1[6-9]|[2-9]\\d)?\\d{2})\$");
                            if (!regExp.hasMatch(cubit.bodController.text)) {
                              return "يرجى ادخال التاريخ بالشكل الصحيح";
                            }
                            return null;
                          },
                          textController: cubit.bodController,
                          label: "تاريخ الميلاد*",
                          iconButton: IconButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101),
                              );
                            },
                            icon: const Icon(Icons.calendar_today,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: MyTextFieldDark(
                          textController: cubit.passwordController,
                          isObscure: true,
                          minHeight: 1,
                          validator: (errorMessage) {
                            //encloser
                            if (cubit.passwordController.text.isNotEmpty &&
                                cubit.passwordController.text.length < 6) {
                              return "كلمة المرور يجب ان تكون على الاقل ٦ احرف";
                            }
                            return null;
                          },
                          maxLines: 1,
                          label: "كلمة المرور",
                          iconButton: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.remove_red_eye,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: MyTextFieldDark(
                          textController: cubit.passwordConfirmController,
                          validator: (value) {
                            if (cubit.passwordController.text.isNotEmpty &&
                                cubit.passwordController.text !=
                                    cubit.passwordConfirmController.text) {
                              return "كلمة السر غير متطابقة";
                            }
                            return null;
                          },
                          isObscure: true,
                          minHeight: 1,
                          maxLines: 1,
                          label: "تأكيد كلمة المرور*",
                          iconButton: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.remove_red_eye,
                            ),
                          ),
                        ),
                      ),
                      state is ProfileUpdateLoadingState
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.updateData(context);
                                }
                              },
                              child: Text(
                                "تحديث",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: const Color(0xffFFE8D6),
                                    ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: const MyBottomNavigationBar(),
          );
        },
      ),
    );
  }
}
