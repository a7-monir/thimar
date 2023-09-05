part of 'bloc.dart';

class ProfileEvents {}

class ProfileStartEvent extends ProfileEvents {
  String name, phone;
  File?imagePath;
  String? cityId;
  ProfileStartEvent({
    required this.name,
    required this.phone,
    required this.cityId,
    required this.imagePath

  });
}