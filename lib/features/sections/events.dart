part of 'bloc.dart';

class CategoriesProductEvents {}

class CategoriesProductStartEvent extends CategoriesProductEvents {
  int productsId;
  double? min,max;
  CategoriesProductStartEvent({
    required this.productsId,
    this.min,
    this.max,
  });
}

