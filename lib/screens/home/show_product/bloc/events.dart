class ShowProductEvents {}

class ShowProductStartEvent extends ShowProductEvents {
  final int productsId;
  ShowProductStartEvent({
    required this.productsId,
  });
}