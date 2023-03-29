import 'package:flutter/material.dart';
import 'package:flutter_menu/features/dashboard/model/dashboard_item.dart';
import 'package:flutter_menu/features/order/models/order.dart';
import 'package:flutter_menu/features/order/repositories/order_repository.dart';
import 'package:get/get.dart';

class OrderPageController extends GetxController {
  OrderStatus? status;
  final OrderRepository _orderRepository = Get.find();
  Rxn<List<DashboardItem>> items = Rxn<List<DashboardItem>>();

  void loadOrders(OrderStatus? status) {
    this.status = status;
    _getOrders();
  }

  Future<void> _getOrders() async {
    try {
      final orders = await _orderRepository.getOrders(status);
      if (status == OrderStatus.delivered) {
        final items = <DashboardItem>[];

        this.items.value = items;
      } else {
        items.value = orders
            .map<DashboardItem>((e) => DashboardItem(orders: [e]))
            .toList();
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
