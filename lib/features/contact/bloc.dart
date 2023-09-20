import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:thimar/core/logic/helper_methods.dart';

import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class ContactBloc extends Bloc<ContactEvents,ContactStates>{

  ContactBloc(this.serverGate):super(ContactStates()){
    on<ContactStartEvent>(getData);
    on<CreateContactStartEvent>(createContact);
  }

  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final ServerGate serverGate;

  void getData(ContactStartEvent event, Emitter<ContactStates>emit) async {

    emit(ContactLoadingState());

    final response= await serverGate.getFromServer(url: 'contact');

    if(response.success){
      final contactModel= ContactData.fromJson(response.response!.data);
      emit(ContactSuccessState(model:contactModel,));
    }else{
      emit(ContactFailedState(msg: response.msg, statusCode: response.errType!));
    }
  }

  void createContact(CreateContactStartEvent event, Emitter<ContactStates>emit)async{
    emit(CreateContactLoadingState());

    final response =await serverGate.sendToServer(
      url: 'contact',
      body: {
        'phone': phoneController.text.trim(),
        'fullname': nameController.text.trim(),
        'title': titleController.text.trim(),
        'content': contentController.text.trim(),
      }
    );
    if(response.success){
      emit(CreateContactSuccessState(msg: response.msg));
    }
    else{emit(CreateContactFailedState(msg: response.msg, statusCode: response.errType!));
    }


  }
}