import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_menu/features/dashboard/model/dashboard_item.dart';
import 'package:flutter_menu/features/order/models/order.dart';
import 'package:flutter_menu/features/order/repositories/order_repository.dart';
import 'package:get/get.dart';

class DashboardPageController extends GetxController {
  DashboardPageController();

  OrderStatus? status;
  final OrderRepository _orderRepository = Get.find();

  Rxn<List<DashboardItem>> items = Rxn<List<DashboardItem>>();

  late Timer _timer;
  int _count = 0;

  void loadOrders(OrderStatus? status) {
    this.status = status;
    _getOrders();
  }

  @override
  void onInit() {
    super.onInit();

    _startTimer();
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

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      update();
      _count++;
      if (_count >= 5) {
        _count = 0;
        _getOrders();
      }
    });
  }

  Future<void> setOrderDelivered(Order order) async {
    _removeOrderFromDashboard(order);

    await _orderRepository.setOrderStatus(order.id, OrderStatus.delivered);
  }

  Future<void> setOrderPaid(Order order) async {
    _removeOrderFromDashboard(order);

    await _orderRepository.setOrderStatus(order.id, OrderStatus.paid);
  }

  Future<void> setAllOrdersPaid(DashboardItem item) async {
    while (item.orders.isNotEmpty) {
      setOrderPaid(item.orders.first);
    }
  }

  void _removeOrderFromDashboard(Order order) {
    items.update((items) {});
  }

  @override
  void onClose() {
    _timer.cancel();
  }
}
