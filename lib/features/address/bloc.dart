

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../../helper/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class AddressBloc extends Bloc<AddressEvent,AddressState>{

  AddressBloc(this.serverGate):super(AddressState()){
    on<GetAddressStartEvent>(getAddress);
    on<DeleteAddressStartEvent>(deleteAddress);
    on<AddAddressStartEvent>(addAddress);
  }

  AddressModel? model ;
  final ServerGate serverGate;
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();
  double? lat,lng;
  int? isDefault;
  List<Placemark> position=[];
  String? type ;


  void getAddress(GetAddressStartEvent event, Emitter<AddressState>emit) async {

    emit(GetAddressLoadingState());

    final response= await serverGate.getFromServer(url: 'client/addresses');

    if(response.success){
      model= AddressModel.fromJson(response.response!.data);
      emit(GetAddressSuccessState());
    }else{
      emit(GetAddressFailedState(error: response.msg, errType: response.errType!));
    }
  }

  void deleteAddress(DeleteAddressStartEvent event, Emitter<AddressState>emit)async{

    emit(DeleteAddressLoadingState());

    final response= await serverGate.deleteFromServer(url: 'client/addresses/${event.id}');

    if(response.success){
      model!.list.removeAt(event.index);
      emit(DeleteAddressSuccessState());
    }else{
      emit(DeleteAddressFailedState(error: response.msg, errType: response.errType!));
    }





  }


  void editAddress(EditAddressStartEvent event, Emitter<AddressState>emit)async{

    emit(EditAddressLoadingState());

    final response= await serverGate.putToServer(url: 'client/addresses/${event.id}',);

    if(response.success){
      model= AddressModel.fromJson(response.response!.data);
      emit(EditAddressSuccessState());
    }else{
      emit(EditAddressFailedState(error: response.msg, errType: response.errType!));
    }
  }
  
  
  void addAddress(AddAddressStartEvent event, Emitter<AddressState>emit)async{
     
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

      emit(AddAddressSuccessState());
    }
    else{emit(AddAddressFailedState(error: response.msg, errType: response.errType!));}

  }

}