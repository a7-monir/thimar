

class SliderModel{
  SliderModel({
    required this.data,
    required this.status,
    required this.message,
  });

  List<Datum> data;
  String status;
  String message;

  factory SliderModel.fromJson(Map< String, dynamic > json) => SliderModel(
    data:  List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };



}

class Datum{
  Datum({
    required this.id,
    required this.media,
  });

  int id;
  String media;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    media: json["media"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "media": media,
  };
}