
 class ShowProductModel {
   ShowProductModel({
     required this.status,
     required this.message,
     required this.data,
   });
   String status;
   String message;
   Data data;

   factory ShowProductModel.fromJson(Map<String, dynamic> json) => ShowProductModel(
     status: json["status"],
     message: json["message"],
     data: Data.fromJson(json["data"]),
   );

 }
 class Data {
   Data({
     required this.categoryId,
     required this.id,
     required this.title,
     required this.description,
     required this.code,
     required this.priceBeforeDiscount,
     required this.price,
     required this.discount,
     required this.amount,
     required this.isActive,
     required this.isFavorite,
     required this.unit,
     required this.images,
     required this.mainImage,
     required this.createdAt,
   });

   int categoryId;
   int id;
   String title;
   String description;
   String code;
   int priceBeforeDiscount;
   dynamic price;
   double discount;
   int amount;
   int isActive;
   bool isFavorite;
   Unit unit;
   List<Image> images;
   String mainImage;
   DateTime createdAt;

   factory Data.fromJson(Map<String, dynamic> json) => Data(
     categoryId: json["category_id"],
     id: json["id"],
     title: json["title"],
     description: json["description"],
     code: json["code"],
     priceBeforeDiscount: json["price_before_discount"],
     price: json["price"],
     discount: json["discount"].toDouble(),
     amount: json["amount"],
     isActive: json["is_active"],
     isFavorite: json["is_favorite"],
     unit: Unit.fromJson(json["unit"]),
     images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
     mainImage: json["main_image"],
     createdAt: DateTime.parse(json["created_at"]),
   );
 }

 class Image {
   Image({
     required this.name,
     required this.url,
   });

   String name;
   String url;

   factory Image.fromJson(Map<String, dynamic> json) => Image(
     name: json["name"],
     url: json["url"],
   );

   Map<String, dynamic> toJson() => {
     "name": name,
     "url": url,
   };
 }

 class Unit {
   Unit({
     required this.id,
     required this.name,
     required this.type,
     required this.createdAt,
     required this.updatedAt,
   });

   int id;
   String name;
   String type;
   DateTime createdAt;
   DateTime updatedAt;

   factory Unit.fromJson(Map<String, dynamic> json) => Unit(
     id: json["id"],
     name: json["name"],
     type: json["type"],
     createdAt: DateTime.parse(json["created_at"]),
     updatedAt: DateTime.parse(json["updated_at"]),
   );
 }
