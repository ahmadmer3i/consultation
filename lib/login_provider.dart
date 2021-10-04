import 'package:consultation/Provider/provider_dashboard.dart';
import 'package:consultation/login_seeker.dart';
import 'package:consultation/pre_register.dart';
import 'package:consultation/view_model/get_provider_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'models/provider_data.dart';

class LoginProvider extends StatefulWidget {
  const LoginProvider({Key? key}) : super(key: key);

  @override
  _LoginProviderState createState() => _LoginProviderState();
}

class _LoginProviderState extends State<LoginProvider> {
  FirebaseAuth instance = FirebaseAuth.instance; // الربط مع الداتا اوثنتكيشن
  Future<List<ProviderData>>? getProvider;
  List<ProviderData> providerList = [];
  late String _email, _password;
  late bool _isObscure = true;
  var key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getProvider = getProviderData(providerList);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      resizeToAvoidBottomInset: true,

      // ignore: prefer_const_constructors
      backgroundColor: Color(0xffFFE8D6),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40, bottom: 10),
            child: Image.asset(
              "Assets/Logo2.png",
              height: 100,
            ),
          ),
          Image.asset(
            "Assets/providerIllustration.png",
            height: 150,
          ),
          Text(
            'تسجيل الدخول كمستشار',
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
                            margin: const EdgeInsets.only(bottom: 20, top: 20),
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: "البريد الألكتروني",
                              ), //كود التحقق من الايميل و الباسورد
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
                            child: TextField(
                              onChanged: (value) {
                                setState(
                                  () {
                                    _password = value;
                                  },
                                );
                              },
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                labelText: " كلمة المرور*",
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
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Text(
                                "هل نسيت كلمة السر؟",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: const Color(0xffFFE8D6),
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginSeeker(),
                                  ),
                                );
                              },
                              child: Text(
                                "هل أنت مستفيد؟",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: const Color(0xffFFE8D6),
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: getProvider,
                            builder: (context,
                                AsyncSnapshot<List<ProviderData>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      // UserCredential credential =
                                      // await instance.signInWithEmailAndPassword(
                                      //     email: _email, password: _password);
                                      for (var provider in providerList) {
                                        if (provider.email == _email &&
                                            provider.password == _password) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProviderDashboard(),
                                            ),
                                          );
                                        }
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == "invalid-email") {
                                        // print("invalid-email");
                                      } else if (e.code == "wrong-password") {
                                        // print("wrong-password");
                                      } else if (e.code == "user-disabled") {
                                        // print("user-disabled");
                                      } else if (e.code == "user-not-found") {
                                        // print("user-not-found");
                                      }
                                    }
                                  },
                                  child: Text(
                                    "تسجيل الدخول",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: const Color(0xffFFE8D6),
                                        ),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.amber,
                                  ),
                                );
                              }
                            },
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const PreRegister(),
                                  ),
                                );
                              },
                              child: Text(
                                "ليس لديك حساب؟ سجل هنا",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: const Color(0xffFFE8D6),
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
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
