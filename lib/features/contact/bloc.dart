import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../helper/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class ContactBloc extends Bloc<ContactEvents,ContactState>{

  ContactBloc(this.serverGate):super(ContactState()){
    on<ContactStartEvent>(contact);
    on<CreateContactStartEvent>(createContact);
  }

  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  ContactModel? model ;
  final ServerGate serverGate;

  void contact(ContactStartEvent event, Emitter<ContactState>emit) async {

    emit(ContactLoadingState());

    final response= await serverGate.getFromServer(url: 'contact');

    if(response.success){
      model= ContactModel.fromJson(response.response!.data);
      emit(ContactSuccessState());
    }else{
      emit(ContactFailedState(error: response.msg, errType: response.errType!));
    }
  }

  void createContact(CreateContactStartEvent event, Emitter<ContactState>emit)async{
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
      emit(CreateContactSuccessState());
    }
    else{emit(CreateContactFailedState(error: response.msg, errType: response.errType!));
    }


  }
}