import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';
import 'package:thimar/screens/auth/register/bloc/events.dart';
import 'package:thimar/screens/auth/register/bloc/states.dart';

import '../../../../helper/server_gate.dart';
import '../../../../helper/toast.dart';
import '../view.dart';
import 'model.dart';

class RegisterBloc extends Bloc<RegisterEvents,RegisterState>{

  RegisterBloc():super (RegisterState() ){
    on<RegisterGetCitiesStartEvents>(_getCitiesData);
    on<RegisterStartEvents>(Register);


  }

  final formKey =GlobalKey<FormState>();

  String? cityId;
  String? cityName;
  final fullNameController=TextEditingController();
  final passwordController=TextEditingController();
  final confirmationPasswordController=TextEditingController();
  final phoneController=TextEditingController();
  final cityController=TextEditingController();

  ServerGate serverGate = ServerGate();


  unfocus(BuildContext context) {
    var currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
  bool isDataVaild(context) {
    if (fullNameController.text.trim().isNotEmpty) {
      if (phoneController.text.trim().isNotEmpty) {
        if (passwordController.text.trim().isNotEmpty) {
          if (confirmationPasswordController.text.trim().isNotEmpty) {
            if (passwordController.text.trim() ==
                confirmationPasswordController.text.trim()) {
              return true;
            } else {
              Toast.show("passwordsNotMatched", context);
              return false;
            }
          } else {
            Toast.show("PleaseWriteYourConfirmPassword", context);
            return false;
          }
        } else {
          Toast.show("PleaseWriteYourPassword", context);
          return false;
        }
      } else {
        Toast.show("PleaseWriteYourPhoneNumber", context);
        return false;
      }
    } else {
      Toast.show("PleaseWriteYourName", context);
      return false;
    }
  }

  void _getCitiesData(RegisterGetCitiesStartEvents event,Emitter<RegisterState> emit )async{

    emit(RegisterGetCitiesLoadingState());
    CustomResponse response =await serverGate.getFromServer(
        url: 'cities/1',);
    if (response.success) {
      final model = CityDataModel.fromJson(response.response!.data);
      emit(RegisterGetCitiesSuccessState(model: model));
    } else {
      emit(RegisterGetCitiesFailState(error: response.msg.toString()));
    }
  }

  void Register (RegisterStartEvents event, Emitter <RegisterState> emit) async{
    emit(RegisterLoadingState());

    CustomResponse response = await serverGate.sendToServer(
      url: 'client_register',
      body:{
        'fullname':fullNameController.text.trim(),
        'password':passwordController.text.trim(),
        'password_confirmation':confirmationPasswordController.text.trim(),
        'phone':phoneController.text.trim(),
        'gender':'female',
        'lat':'250.0515',
        'lng':'290.45',

      },
    );
    if (response.success)
    {
      emit(RegisterSuccessState());
    }else {
      emit(RegisterFailState(type:response.errType!.toInt(), error: response.msg.toString()));
    }
  }

}


