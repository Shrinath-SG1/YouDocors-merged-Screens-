import 'package:YOURDRS_FlutterAPP/blocs/login_bloc.dart';
import 'package:YOURDRS_FlutterAPP/data/service/user_service.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/login_screen/splash_screen.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin_screen/verify_security_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var login = prefs.getString('isPINAvailable');
  print(login);
  runApp(BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(ApiServices()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  login == null || login == "" ? SplashScreen() : VerifyPinScreen(),)));
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