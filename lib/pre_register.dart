import 'package:consultation/Provider/provider_registration.dart';
import 'package:consultation/Seeker/seeker_registration.dart';
import 'package:flutter/material.dart';

class PreRegister extends StatefulWidget {
  const PreRegister({Key? key}) : super(key: key);

  @override
  _PreRegisterState createState() => _PreRegisterState();
}

class _PreRegisterState extends State<PreRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff6B705C),
      body: Column(
        children: [
          Expanded(
            child: Image.asset('Assets/Logo3.png'),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SeekerRegistration(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 150),
                      child: Image.asset(
                        'Assets/seekerillustration.png',
                      ),
                    ),
                    Text(
                      'تسجيل الدخول كمستفيد',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: const Color(0xffFFE8D6)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProviderRegistration(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 150),
                      child: Image.asset(
                        'Assets/providerIllustration.png',
                      ),
                    ),
                    Text(
                      'تسجيل الدخول كمستشار',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: const Color(0xffFFE8D6),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
