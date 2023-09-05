part of 'bloc.dart';
class ProductEvents {}

class ShowProductStartEvent extends ProductEvents {
  final num productsId;
  ShowProductStartEvent({
    required this.productsId,
  });
}

class GetProductRateStartEvent extends ProductEvents{

  final num productsId;
  GetProductRateStartEvent({

    required this.productsId,

  });
}

class AddToFavoritesStartEvent extends ProductEvents{
  final num productsId;

  AddToFavoritesStartEvent({required this.productsId});
}


class RemoveFromFavoritesStartEvent extends ProductEvents{
  final num productsId;

  RemoveFromFavoritesStartEvent({required this.productsId});
}


