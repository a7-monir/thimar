part of 'bloc.dart';

class AddressEvent {}

class GetAddressStartEvent extends AddressEvent {}

class DeleteAddressStartEvent extends AddressEvent {
  final int id;
  final int index;
  DeleteAddressStartEvent({required this.id, required this.index});
}

class EditAddressStartEvent extends AddressEvent {
  final int id;
  final int index;
  EditAddressStartEvent({required this.id, required this.index});
}

class AddAddressStartEvent extends AddressEvent {
  final String? type,
      description, phone;
  final String? location;
  final double lat, lng;
  final int?isDefault;

  AddAddressStartEvent({
    required this.type,
    required this.location,
    required this.description,
    required this.phone,
    required this.lat,
    required this.lng,
   required this.isDefault,
  });
}
