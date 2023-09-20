

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:thimar/core/logic/helper_methods.dart';

import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class AddressBloc extends Bloc<AddressEvent,AddressStates>{

  AddressBloc(this.serverGate):super(AddressStates()){
    on<GetAddressStartEvent>(getData);
    on<DeleteAddressStartEvent>(deleteAddress);
    on<AddAddressStartEvent>(addAddress);
  }
  AddressData? modell;
  final ServerGate serverGate;
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();
  double? lat,lng;
  int? isDefault;
  List<Placemark> position=[];
  String? type ;


  void getData(GetAddressStartEvent event, Emitter<AddressStates>emit) async {

    emit(GetAddressLoadingState());

    final response= await serverGate.getFromServer(url: 'client/addresses');

    if(response.success){
      final addressModel= AddressData.fromJson(response.response!.data);
      emit(GetAddressSuccessState(model: addressModel));
    }else{
      emit(GetAddressFailedState(msg: response.msg, statusCode: response.errType!));
    }
  }

  void deleteAddress(DeleteAddressStartEvent event, Emitter<AddressStates>emit)async{

    emit(DeleteAddressLoadingState());

    final response= await serverGate.deleteFromServer(url: 'client/addresses/${event.id}');

    if(response.success){
      modell!.list.removeAt(event.index);
      emit(DeleteAddressSuccessState());
    }else{
      emit(DeleteAddressFailedState(msg: response.msg, statusCode: response.errType!));
    }





  }


  void editAddress(EditAddressStartEvent event, Emitter<AddressStates>emit)async{

    emit(EditAddressLoadingState());

    final response= await serverGate.putToServer(url: 'client/addresses/${event.id}',);

    if(response.success){
      final addressModel= AddressData.fromJson(response.response!.data);
      emit(EditAddressSuccessState(model: addressModel,msg: response.msg));
    }else{
      emit(EditAddressFailedState(msg: response.msg, statusCode: response.errType!));
    }
  }
  
  
  void addAddress(AddAddressStartEvent event, Emitter<AddressStates>emit)async{
     
    emit(AddAddressLoadingState());
    final response= await serverGate.sendToServer(url: "client/addresses",
    body: {
      'type': type,
      'phone': phoneController.text,
      'description':descriptionController.text,
      'location': position,
      'lat': lat,
      'lng': lng,
      'is_default': isDefault,
    });
    if(response.success) {

      emit(AddAddressSuccessState(msg: response.msg));
    }
    else{emit(AddAddressFailedState(msg: response.msg, statusCode: response.errType!));}

  }

}