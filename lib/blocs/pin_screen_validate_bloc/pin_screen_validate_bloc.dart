import 'dart:async';
import 'package:YOURDRS_FlutterAPP/data/model/pin_validate_model.dart';
import 'package:YOURDRS_FlutterAPP/data/repo/local/preference/local_storage.dart';
import 'package:YOURDRS_FlutterAPP/data/service/pin_validate_api.dart';
import 'package:bloc/bloc.dart';

part 'pin_screen_validate_event.dart';

part 'pin_screen_validate_state.dart';

class PinScreenBloc extends Bloc<PinScreenEvent, PinScreenState> {
  PinRepo pinRepo;         ///creating object of model class for pin generation
  PinScreenBloc(this.pinRepo) : super(PinScreenState(isTrue: true));

  @override

  Stream<PinScreenState> mapEventToState(
    PinScreenEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is PinScreenEvent){

      var memberId =
      await MySharedPreferences.instance.getStringValue(Keys.memberId);   ///here we are storing storing member id in variable and passing that to API request
      print('memberID $memberId');

      PinResponse pinResponse= await pinRepo.postApiMethod(memberId.toString(), event.pin);  ///passing member id and pin as request to API.
      print('Triggered////////////////////////////////');

      print(pinResponse);

      if(pinResponse.header.statusCode=="200") {     ///if response code is 200 user will be navigated to next screen.
        var username=pinResponse.userName;
        print('HomeScreen user is $username');
        yield PinScreenState(isTrue: true,name: username);
      }
      else if (pinResponse.header.statusCode== "401"){
        print('ShowSnackbar');
         yield PinScreenState(isTrue: false);
      }
      else{
        print('Unknown Error');
      }
    }
  }
}
