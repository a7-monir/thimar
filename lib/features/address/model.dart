part of 'bloc.dart';

class AddressData {

  late final List<AddressModel> list;

  AddressData.fromJson(Map<String, dynamic> json){
    print('=-=-=-=-=-=-=-=-=-=-=-=-=-=--------=-=-=-=-');
    print(json['data']);
    list = List.from(json['data']).map((e)=>AddressModel.fromJson(e)).toList();

  }
}

class AddressModel {
  late final int id;
  late final String type,location, description,phone;
  late final double lat, lng;
  late final bool isDefault;


  AddressModel.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    type = json['type']??'';
    lat = double.tryParse( json['lat'].toString())??0;
    lng = json['lng']??0.0;
    location = json['location']??'';
    description = json['description']??'';
    isDefault = json['is_default']??false;
    phone = json['phone']??'';
  }

}