import 'dart:developer';

import 'package:YOURDRS_FlutterAPP/blocs/login_bloc.dart';
import 'package:YOURDRS_FlutterAPP/data/repo/local/preference/local_storage.dart';
import 'package:YOURDRS_FlutterAPP/data/service/user_service.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/loginscreen.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin/confirm_pin.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin/create_security_pin.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin/verify_security_pin.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MyApp());
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var login = prefs.getString('username');
  // print(login);
  // runApp(BlocProvider<LoginBloc>(
  //     create: (context) => LoginBloc(ApiServices()),
  //     child: MaterialApp(
  //         debugShowCheckedModeBanner: false,
  //         home: login == null ? SplashScreen() : VerifyPinScreen())));
}

class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(ApiServices()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: SplashScreen(),
      ),
    );
  }
}
