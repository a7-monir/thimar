part of 'bloc.dart';

class AddressModel {

  late final List<Data> list;

  AddressModel.fromJson(Map<String, dynamic> json){
    print('=-=-=-=-=-=-=-=-=-=-=-=-=-=--------=-=-=-=-');
    print(json['data']);
    list = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();

  }
}

class Data {
  late final int id;
  late final String type,location, description,phone;
  late final double lat, lng;
  late final bool isDefault;


  Data.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    type = json['type']??'';
    lat = json['lat']??0.0;
    lng = json['lng']??0.0;
    location = json['location']??'';
    description = json['description']??'';
    isDefault = json['is_default']??false;
    phone = json['phone']??'';
  }

}