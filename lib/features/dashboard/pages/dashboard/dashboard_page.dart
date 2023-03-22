import 'package:flutter/material.dart';
import 'package:flutter_menu/features/dashboard/pages/dashboard/dashboard_page_controller.dart';
import 'package:flutter_menu/features/dashboard/pages/dashboard/widgets/dashboard_card.dart';
import 'package:flutter_menu/features/order/models/order.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required this.status}) : super(key: key);

  final OrderStatus? status;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardPageController controller = Get.put(DashboardPageController());

  @override
  void initState() {
    super.initState();

    controller.loadOrders(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<DashboardPageController>(
          builder: (_) {
            return Obx(() {
              if (controller.items.value == null) {
                return Center(
                  child: LoadingAnimationWidget.inkDrop(
                    color: Colors.white,
                    size: 50,
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final i in controller.items.value!)
                      DashboardCard(
                        item: i,
                      ),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
