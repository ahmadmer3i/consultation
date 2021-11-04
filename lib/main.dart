// ignore_for_file: prefer_const_construsctors

import 'package:consultation/login_provider.dart';
import 'package:consultation/login_seeker.dart';
import 'package:consultation/splash_screen.dart';
import 'package:consultation/tools/bloc_observer.dart';
import 'package:consultation/view_model/messages_cubit.dart';
import 'package:consultation/view_model/provider/provider_instant_cubit/instant_cubit.dart';
import 'package:consultation/view_model/schedule_cubit/schedule_cubit.dart';
import 'package:consultation/view_model/search_cubit/search_cubit.dart';
import 'package:consultation/view_model/seeker_cubit/seeker_cubit.dart';
import 'package:consultation/view_model/time_cubit/time_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//we used async and await because the method type is future
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(30, 30, 30, .1),
      100: Color.fromRGBO(30, 30, 30, .2),
      200: Color.fromRGBO(30, 30, 30, .3),
      300: Color.fromRGBO(30, 30, 30, .4),
      400: Color.fromRGBO(30, 30, 30, .5),
      500: Color.fromRGBO(30, 30, 30, .6),
      600: Color.fromRGBO(30, 30, 30, .7),
      700: Color.fromRGBO(30, 30, 30, .8),
      800: Color.fromRGBO(30, 30, 30, .9),
      900: Color.fromRGBO(30, 30, 30, 1),
    };
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MessagesCubit(),
        ),
        BlocProvider(
          create: (context) => InstantCubit(),
        ),
        BlocProvider(
          create: (context) => TimeCubit()..getTimeIntervals(),
        ),
        BlocProvider(
          create: (context) => ScheduleCubit()..getScheduledDataProvider(),
        ),
        BlocProvider(
          create: (context) => SeekerCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit()..getAllProviders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // ignore: prefer_const_literals_to_create_immutables
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        // ignore: prefer_const_literals_to_create_immutables
        supportedLocales: [
          const Locale("ar", "IR"),
        ],
        locale: const Locale("ar", "IR"),

        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: const Color(0xffCB997E),
          fontFamily: "Janna",
          primarySwatch: MaterialColor(0xFFCB997E, color),
        ),
        home: const LoginSeeker(),
        initialRoute: "/SplashScreen",
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/LoginSeeker': (context) => const LoginSeeker(),
          '/SplashScreen': (context) => const SplashScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/LoginProvider': (context) => const LoginProvider(),
        },
      ),
    );
  }
}
