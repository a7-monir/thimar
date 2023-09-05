part of 'bloc.dart';

class ContactEvents{}

class ContactStartEvent extends ContactEvents{}

class CreateContactStartEvent extends ContactEvents{
  String phone, fullname,title,content;

  CreateContactStartEvent({
    required this.phone,
    required this.fullname,
    required this.title,
    required this.content,

  });
}