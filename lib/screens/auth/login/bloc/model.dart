

class LoginModel{

  LoginModel({
    required this.data,
    required this.status,
    required this.message
  });

  String status;
  String message;
  Data data;

  factory LoginModel.fromJson(Map<String,dynamic> json)=>LoginModel(
    data: Data.fromJson(json["data"] ??'' ),
    status: json["status"] ?? '',
    message: json["message"] ?? '',
  );
}

class Data {
  Data({
    required this.id,
    required this.fullname,
    required this.phone,
    required this.email,
    required this.image,
    required this.isBan,
    required this.isActive,
    required this.unreadNotifications,
    required this.userType,
    required this.token,
    required this.country,
    required this.city,
    required this.identityNumber,
    required this.userCartCount,
  });

  int id;
  String fullname;
  String phone;
  String email;
  String image;
  int isBan;
  bool isActive;
  int unreadNotifications;
  String userType;
  String token;
  Country? country;
  City? city;
  dynamic identityNumber;
  int userCartCount;

  factory Data.fromJson(Map<String,dynamic> json)=>
      Data(
          id: json['id'] ??0 ,
          fullname: json['fullname']??'',
          phone: json['phone'] ??'' ,
          email: json['email']??'',
          image: json['image']??'',
          isBan: json['isBan']??0,
          isActive: json['isActive'] ?? false,
          unreadNotifications: json['unreadNotifications']??0,
          userType: json['userType'] ?? '',
          token: json['token'] ?? '',
          country: json['country']   ,
          city: json['city'],
          identityNumber: json['identityNumber'] ?? 0,
          userCartCount: json['userCartCount'] ?? 0);
}

class City {
  City({
    required this.id,
    required this.name,
  });

  dynamic id;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"] ?? 0,
    name: json["name"]??'',
  );
}

class Country {
  Country({
    required this.id,
    required this.name,
    required this.nationality,
    required this.key,
    required this.flag,
  });

  dynamic id;
  String name;
  String nationality;
  String key;
  String flag;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"] ?? 1,
    name: json["name"]??'',
    nationality: json["nationality"]??'',
    key: json["key"]??'',
    flag: json["flag"]??'',
  );
}