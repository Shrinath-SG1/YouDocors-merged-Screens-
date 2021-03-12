
import 'package:YOURDRS_FlutterAPP/blocs/login_bloc.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/data/service/user_service.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/login_screen/loginscreen.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/login_screen/splash_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/app_icons.dart';

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
          home:SplashScreen(),
           ),
      );

  }
}

// AnimatedSplashScreen(
//     duration: 3000,
//     splash: Container(
//       child: Column(children: [
//         Container(
//           color: Colors.cyanAccent,
//           alignment: Alignment.bottomCenter,
//           //color: Colors.cyanAccent,
//           child: Image.asset(
//             AppImages.SplashLogo,fit: BoxFit.fill,
//             height: 80,
//             width: 80,
//           ),
//         ),
//         // FractionalTranslation(
//         //   translation: Offset(0.0, -0.3),
//         //   child: Text(
//         //     AppStrings.yourDrs,
//         //     style: TextStyle(
//         //         color: Colors.white,
//         //         fontSize: 50,
//         //         letterSpacing: 2,
//         //         fontWeight: FontWeight.bold),
//         //   ),
//         // ),
//       ],),
//     ),
//     nextScreen: LoginScreen(),
//     splashTransition: SplashTransition.scaleTransition,
//    // pageTransitionType:  PageTransitionT
//     backgroundColor: Colors.blue
// ),