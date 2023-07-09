class CategoriesProductEvents {}

class CategoriesProductStartEvent extends CategoriesProductEvents {
  int categoriesProductId;
  CategoriesProductStartEvent({
    required this.categoriesProductId,
  });
}
