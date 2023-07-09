

class CategoryProductModel {
  CategoryProductModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.status,
    required this.message,
  });

  List<Datum> data;
  Links links;
  Meta meta;
  String status;
  String message;

  factory CategoryProductModel.fromJson(Map<String, dynamic> json) => CategoryProductModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    status: json["status"],
    message: json["message"],
  );
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "id": id,
    "title": title,
    "description": description,
    "code": code,
    "price_before_discount": priceBeforeDiscount,
    "price": price,
    "discount": discount,
    "amount": amount,
    "is_active": isActive,
    "is_favorite": isFavorite,
    "main_image": mainImage,
    "created_at":
    "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
  };
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

class Links {
  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  String first;
  String last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] ?? "",
    label: json["label"],
    active: json["active"],
  );
}