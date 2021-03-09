import 'package:YOURDRS_FlutterAPP/blocs/login_bloc.dart';
import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_icons.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/data/repo/local/preference/local_storage.dart';
import 'package:YOURDRS_FlutterAPP/ui/home/Home.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin/DemoScreen.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin/create_security_pin.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin/verify_security_pin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {

  bool _passwordvisible;
  final _formKey = GlobalKey<FormState>();
  var memberID;

  bool visible = false ;


  /// Text editing Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// Shared Preference
  SharedPreferences logindata;
  SharedPreferences MemberIdData;
  bool newuser;

  @override
  void initState() {
    super.initState();
     check_if_already_login();
    _passwordvisible = false;

    super.initState();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => VerifyPinScreen()));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var hight=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return BlocListener<LoginBloc, FormScreenState>(
      listener: (context, state) {
        /// if the status code is true it execute the statement else go to next statement
        if (state.isTrue == true) {
          if(state.isPinAvailable==true){
            Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Welcome()));
          }else{
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => CreatePinScreen(data: state.memberId,)));

          }
        } else {
         visible=false;
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Row(
                children: [
                  Text(
                    AppStrings.wrong_password_email,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // isLoading ? Container(                        ///it will show loading screen on press
            //   //color: Colors.black.withOpacity(0.5),
            //   child: Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // ) :
            Center(
            child: BlocBuilder<LoginBloc, FormScreenState>(
                builder: (context, state) {
              return ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      /// Container for your doctor text with image
                      Container(
                        child: Row(
                          // which add Row properties at the center
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.your,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: CustomizedColors.your_text_color),
                            ),
                            Text(
                              AppStrings.doctors,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: CustomizedColors.doctor_text_color),
                            ),
                            Image.asset(
                              AppIcons.doctor_img,
                              // I added asset image
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: hight*0.06,),


                      /// Container for welcome screen Text
                      Container(
                        child: Text(
                          AppStrings.welcome_text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        ),
                      ),
                      SizedBox(height: hight*0.04,),

                      /// Container for your_doctors quote text
                      Container(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: hight * 0.2,
                            maxWidth: width* 0.9,
                          ),
                          child: Text(
                            AppStrings.your_doctor_text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: CustomizedColors.your_doctors_text_color),
                          ),
                        ),
                      ),
                      SizedBox(height: hight*0.02,),
                      Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: visible,
                          child: Container(
                              child: CircularProgressIndicator()
                          ),
                      ),
                      SizedBox(height: hight*0.02,),

                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// Form field which contains two TextFormField
                            Form(
                              key: _formKey,
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: CustomizedColors
                                            .text_field_background,
                                        borderRadius: BorderRadius.circular(10),
                                      ),

                                      /// TextFormField for Email
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return AppStrings.enter_email;
                                          }
                                          return null;
                                        },
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                          border: InputBorder.none,
                                          hintText:
                                              AppStrings.email_text_field_hint,
                                        ),
                                      ),
                                      margin: const EdgeInsets.only(
                                          left: 30, right: 30, top: 60),
                                    ),
                                    SizedBox(height: hight*0.05,),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: CustomizedColors
                                            .text_field_background,
                                        borderRadius: BorderRadius.circular(10),
                                      ),

                                      /// TextFormField for password
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return AppStrings.enter_password;
                                          }
                                          return null;
                                        },
                                        controller: passwordController,
                                        obscureText: !_passwordvisible,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 20, top: 15),
                                          border: InputBorder.none,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _passwordvisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.black54,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _passwordvisible =
                                                    !_passwordvisible;
                                              });
                                            },
                                          ),
                                          hintText:
                                              AppStrings.password_text_field_hint,
                                        ),
                                      ),

                                      margin: const EdgeInsets.only(
                                          left: 30, right: 30),
                                    ),

                                    SizedBox(height: hight*0.04,),
                                  ],
                                ),
                              ),
                            ),

                            /// Implementation for the sign in  Flat button
                            Container(
                              decoration: BoxDecoration(
                                color: CustomizedColors.text_field_background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      // testing shared preferance

                                      print('Successfull');

                                      setState(() {
                                       visible=true;
                                      });

                                      logindata.setBool('login', false);
                                      logindata.setString(
                                          'username', emailController.text);
                                     // testing shared preferance
                                      print(
                                          "This is Email ${emailController.text}");
                                      BlocProvider.of<LoginBloc>(context).add(
                                          FormScreenEvent(emailController.text,
                                              passwordController.text));
                                    }
                                  },
                                  color: CustomizedColors.signInButtonColor,
                                  child: Text(
                                    AppStrings.sign_in,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color:
                                            CustomizedColors.sign_in_text_color),
                                  )),
                              margin: const EdgeInsets.only(
                                  left: 30, right: 30, top: 40),
                            ),
                            // Visibility(
                            //     maintainSize: true,
                            //     maintainAnimation: true,
                            //     maintainState: true,
                            //     visible: visible,
                            //     child: Container(
                            //         margin: EdgeInsets.only(top: 30, bottom: 0),
                            //         child: CircularProgressIndicator()
                            //     )
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
      ]
        ),
      ),
    );
  }
}

// abhishdhjksl
