

class VerificationModel{

  VerificationModel({
    required this.status,
    required this.message,
    required this.data,
});

  String status;
  String message;
  Data data;

  factory VerificationModel.fromJson(Map<String,dynamic>json)=>VerificationModel(
      status: json["status"],
      message: json["message"],
      data: Data.fromJson(json["data"]));
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
  Country country;
  City city;
  dynamic identityNumber;
  int userCartCount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fullname: json["fullname"],
    phone: json["phone"],
    email: json["email"],
    image: json["image"],
    isBan: json["is_ban"],
    isActive: json["is_active"],
    unreadNotifications: json["unread_notifications"],
    userType: json["user_type"],
    token: json["token"],
    country: Country.fromJson(json["country"]),
    city: City.fromJson(json["city"]),
    identityNumber: json["identity_number"],
    userCartCount: json["user_cart_count"],
  );


}
class City {
  City({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
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

  String id;
  String name;
  String nationality;
  String key;
  String flag;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    nationality: json["nationality"],
    key: json["key"],
    flag: json["flag"],
  );
}

