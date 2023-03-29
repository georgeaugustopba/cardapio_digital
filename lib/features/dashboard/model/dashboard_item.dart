import 'package:flutter_menu/features/order/models/order.dart';

class DashboardItem {
  DashboardItem({required this.orders});

  //final User user;
  final List<Order> orders;

  num get total => orders.fold(
      0.0, (previousValue, element) => previousValue + element.totalPrice);
}
