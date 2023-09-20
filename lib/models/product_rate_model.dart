class ProductRateData {
  late final List<ProductRateModel> list;

  ProductRateData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? []).map((e) => ProductRateModel.fromJson(e)).toList();
  }
}

class ProductRateModel {
  late final int value;
  late final String comment, clientName, clientImage;

  ProductRateModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] ?? 0;
    comment = json['comment'] ?? '';
    clientName = json['client_name'] ?? '';
    clientImage = json['client_image'] ?? '';
  }
}
