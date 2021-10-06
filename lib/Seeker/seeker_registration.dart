import 'package:consultation/components.dart';
import 'package:consultation/view_model/login_register/user_register_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SeekerRegistration extends StatefulWidget {
  const SeekerRegistration({Key? key}) : super(key: key);

  @override
  _SeekerRegistrationState createState() => _SeekerRegistrationState();
}

class _SeekerRegistrationState extends State<SeekerRegistration> {
  var key = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance; // الربط مع الداتا اوثنتكيشن
  late String _email, _password, _name, _username, _dateOfBirth, _gender;
  late bool _isObscure = true;
  int selectedGender = 0;
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color(0xffCB997E),
      //   child: Icon(Icons.add,color: Colors.black,),
      //   onPressed: () {
      //     key.currentState!.validate();
      //   },
      // ),

      // ignore: prefer_const_constructors
      backgroundColor: Color(0xffFFE8D6),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80, bottom: 40),
            child: Image.asset(
              "Assets/Logo2.png",
              height: 100,
            ),
          ),
          Text(
            'تسجيل حساب جديد',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: const Color(0xffCB997E),
                ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff6B705C),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: key,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              label: "الأسم بالكامل",
                              //كود التحقق من الايميل و الباسورد
                              onChanged: (value) {
                                setState(
                                  () {
                                    _name = value;
                                  },
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              label: "البريد الألكتروني",
                              //كود التحقق من الايميل و الباسورد
                              onChanged: (value) {
                                setState(
                                  () {
                                    _email = value;
                                  },
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              label: "أسم المستخدم",
                              //كود التحقق من الايميل و الباسورد
                              onChanged: (value) {
                                setState(
                                  () {
                                    _username = value;
                                  },
                                );
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "جنس*",
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        color: Colors.white,
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
                                  color: Color(0xff000000),
                                ),
                              ),
                              onChanged: (int? value) {
                                setState(
                                  () {
                                    selectedGender = value!;
                                  },
                                );
                              },
                              focusColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              value: selectedGender,
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  value: 0,
                                  child: Text(
                                    "ذكر",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text(
                                    "أنثى",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              onChanged: (value) {
                                _dateOfBirth = value;
                              },
                              label: "تاريخ الميلاد*",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015, 8),
                                    lastDate: DateTime(2101),
                                  );
                                },
                                icon: const Icon(
                                  Icons.calendar_today,
                                  color: Colors.white38,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              onChanged: (value) {
                                setState(
                                  () {
                                    _password = value;
                                  },
                                );
                              },
                              isObscure: _isObscure,
                              label: " كلمة المرور*",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      _isObscure = !_isObscure;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              onChanged: (value) {
                                setState(
                                  () {
                                    _password = value;
                                  },
                                );
                              },
                              isObscure: _isObscure,
                              label: "تأكيد كلمة المرور*",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      _isObscure = !_isObscure;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              selectedGender == 0
                                  ? _gender = "M"
                                  : _gender = "F";
                              seekerRegister(
                                email: _email,
                                password: _password,
                                name: _name,
                                username: _username,
                                dateOfBirth: _dateOfBirth,
                                gender: _gender,
                                context: context,
                              );
                              // UserCredential credential =
                              //     await auth.createUserWithEmailAndPassword(
                              //         email: _email, password: _password);
                              //
                              // FirebaseFirestore.instance
                              //     .collection('seeker')
                              //     .add({
                              //   "name": _name,
                              //   "username": _username,
                              //   "email": _email,
                              //   "gender": selectedGender,
                              //   "date of birth": _dateOfBirth,
                              //   "password": _password,
                              //   "Type": "seeker"
                              // });

                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => DashboardSeeker()));
                            },
                            child: Text(
                              "التسجیل",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: const Color(0xffFFE8D6)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
