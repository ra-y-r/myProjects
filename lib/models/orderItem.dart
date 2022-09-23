import 'cartItem.dart';

class OrdersItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime datetime;

  OrdersItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.datetime,
  });
}
