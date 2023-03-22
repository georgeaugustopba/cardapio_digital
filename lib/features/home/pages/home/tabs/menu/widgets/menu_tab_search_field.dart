import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';
import 'package:flutter_menu/features/home/pages/home/tabs/menu/menu_tab_controller.dart';
import 'package:get/get.dart';

class MenuTabSearchField extends StatefulWidget {
  const MenuTabSearchField({Key? key}) : super(key: key);

  @override
  State<MenuTabSearchField> createState() => _MenuTabSearchFieldState();
}

class _MenuTabSearchFieldState extends State<MenuTabSearchField> {
  final TextEditingController searchController = TextEditingController();

  final MenuTabController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: ColorsTheme.kSecondaryColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextFormField(
        key: const Key('search-field'),
        controller: searchController,
        decoration: InputDecoration(
          isCollapsed: true,
          hintText: 'Pesquisar',
          hintStyle: const TextStyle(color: ColorsTheme.kBackgroundColor),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          border: InputBorder.none,
          suffixIcon: controller.search.value.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller.setSearch('');
                    searchController.clear();
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.black26,
                )
              : null,
        ),
        style: const TextStyle(
          color: ColorsTheme.kBackgroundColor,
        ),
        onChanged: controller.setSearch,
      ),
    );
  }
}
