class ProductRateModel {
  late final List<Data> list;

  ProductRateModel.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? []).map((e) => Data.fromJson(e)).toList();
  }
}

class Data {
  late final int value;
  late final String comment, clientName, clientImage;

  Data.fromJson(Map<String, dynamic> json) {
    value = json['value'] ?? 0;
    comment = json['comment'] ?? '';
    clientName = json['client_name'] ?? '';
    clientImage = json['client_image'] ?? '';
  }
}
