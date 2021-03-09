import 'dart:async';

import 'package:YOURDRS_FlutterAPP/data/model/user_class.dart';
import 'package:YOURDRS_FlutterAPP/data/repo/local/preference/local_storage.dart';
import 'package:YOURDRS_FlutterAPP/data/service/user_service.dart';
import 'package:bloc/bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<FormScreenEvent, FormScreenState> {
  ApiServices services;

  LoginBloc(this.services) : super(FormScreenState(isTrue: true));

  @override
  Stream<FormScreenState> mapEventToState(
    FormScreenEvent event,
  ) async* {
    try {
      if (event is FormScreenEvent) {
        AuthenticateUser authenticateUser =
            await services.postApiMethod(event.email, event.password);
        print("My Email is ${event.email}");
        print(authenticateUser);

        bool isPinAvailable;

        /// check if the status value is correct
        if (authenticateUser.header.statusCode == "200") {
          var MemberId=authenticateUser.memberRole[0].memberId.toString();      ///storing member id in variable
          print('Member Id is....$MemberId');
          print('Authenticated Successful');
          var result = await MySharedPreferences.instance.setStringValue(Keys.memberId, MemberId); ///storing member id in shared preference
          print('memberID result $result');

          if(authenticateUser.memberPin!=null){

           yield  FormScreenState(isTrue: true,memberId: MemberId,isPinAvailable: isPinAvailable=true);

          }
          else
            {
              yield FormScreenState(isTrue: true,memberId: MemberId,isPinAvailable: isPinAvailable=false);

            }
          /// if the status value is not true return as false
        } else  {
          print('Authentication Failed');
          yield FormScreenState(isTrue: false);
        }
      }
    } catch (Exception) {
      print("Exception Error");
    }
  }
}
