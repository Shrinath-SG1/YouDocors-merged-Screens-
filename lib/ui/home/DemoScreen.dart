import 'package:YOURDRS_FlutterAPP/common/app_icons.dart';
import 'package:YOURDRS_FlutterAPP/data/repo/local/preference/local_storage.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/login_screen/loginscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  var name="";
  var image="";
  var phone;
  @override
  void initState() {
    super.initState();
    _loadData();

  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString(Keys.displayName) ?? '');
      image= (prefs.getString(Keys.displayPic) ?? '');
      print('name is $name');
      print('img is $image');
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: ClipOval(
            child: image == ""
                ? Image.asset(
                    AppImages.pinImage,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
          ),
          title: name == ""
              ? Text('No User Name')
              : Text(name),
        ),
      ),
      //Text(displayName), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          print('Shared Preference Cleared');
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.remove('login');
          MySharedPreferences.instance.removeValue('memberId');
          MySharedPreferences.instance.removeValue('displayName');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        icon: Icon(Icons.outbond_outlined),
        label: Text("Log Out"),
      ),
      // body: Center(
      //     child: Container(
      //         child: Column(children: [
      //           Image.network(widget.profilePic),
      //           Text(name),
      //           Image.network(image),
      //         ]))),
    );
  }
}
