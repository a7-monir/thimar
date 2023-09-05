import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:thimar/features/login/bloc.dart';
import '../../../../helper/server_gate.dart';
import '../../../../helper/toast.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class RegisterBloc extends Bloc<RegisterEvents,RegisterState>{

  RegisterBloc(this.serverGate):super (RegisterState() ){
    on<RegisterGetCitiesStartEvents>(_getCitiesData);
    on<RegisterStartEvents>(Register);


  }

  final formKey =GlobalKey<FormState>();

  String? cityId;
  String? cityName;
  RegisterModel?model;
  final fullNameController=TextEditingController();
  final passwordController=TextEditingController();
  final confirmationPasswordController=TextEditingController();
  final phoneController=TextEditingController();
  final cityController=TextEditingController();

 final ServerGate serverGate;


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
        'fullname':fullNameController.text,
        'password':passwordController.text,
        'password_confirmation':confirmationPasswordController.text,
        'phone':phoneController.text,
        'gender':'female',
        'lat':'250.0515',
        'lng':'290.45',

      },
    );
    if (response.success)
    {
      model = RegisterModel.fromJson(response.response!.data);
      emit(RegisterSuccessState());
    }else {
      emit(RegisterFailState(type:response.errType!, error: response.msg));
    }
  }

}


