import 'dart:collection';

import 'package:flutter_menu/core/utils/utils_services.dart';
import 'package:flutter_menu/features/cart/models/create_order_model.dart';
import 'package:flutter_menu/features/cart/pages/cart/cart_page_actions.dart';
import 'package:flutter_menu/features/cart/repositories/cart_repository.dart';
import 'package:flutter_menu/features/product/models/product.dart';
import 'package:get/get.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';

class CartController extends GetxController {
  CartController({CartRepository? cartRepository, this.actions})
      : _cartRepository = cartRepository ?? Get.find();

  final RxList<Product> _products = RxList<Product>([]);

  final CartRepository _cartRepository;

  final UtilServices utilServices = UtilServices();

  CartPageActions? actions;

  final Rxn<String> table = Rxn<String>();

  void setTable(String? t) {
    if (t == null) return;
    table.value = t;
  }

  void setActions(CartPageActions? actions) {
    this.actions = actions;
  }

  void addProduct(Product product) {
    _products.add(product);
    utilServices.showToast(message: 'Produto adicionado com sucesso');
  }

  void removeProduct(Product product) {
    _products.remove(product);
    utilServices.showToast(message: 'Produto removido com sucesso');
  }

  void productClean() {
    _products.clear();
  }

  int get productCount => _products.length;
  // int get productCont => productLimited + ;
  bool get productLimited => productCount >= 2;

  int cartItemsQuantity() =>
      _products.map((e) => e.quantity).fold(0, (a, b) => a + b);

  bool get isCheckoutValid => cartItemsQuantity() >= 3;

  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  double get totalPrice => _products.fold(
        0,
        (previousValue, product) => previousValue + product.total,
      );

  final RxString _userName = ''.obs;
  final RxString _userPhone = ''.obs;
  final RxString _userCep = ''.obs;
  final RxString _userRua = ''.obs;
  final RxString _userComplemento = ''.obs;

  String get userName => _userName.value;
  String get userPhone => _userPhone.value;
  String get userCep => _userCep.value;
  String get userRua => _userRua.value;
  String get userComplemento => _userComplemento.value;

  void setUserName(String t) {
    _userName.value = t;
  }

  void setUserPhone(String t) {
    _userPhone.value = t;
  }

  void setUserCep(String t) {
    _userCep.value = t;
  }

  void setUserRua(String t) {
    _userRua.value = t;
  }

  void setUserComplemento(String t) {
    _userComplemento.value = t;
  }

  RxBool loading = false.obs;

  bool get isFormValid =>
      _userName.value.length >= 4 &&
      _userPhone.value.length >= 14 &&
      !loading.value;

  Future<void> sendOrder() async {
    loading.value = true;

    try {
      await _cartRepository.createOrder(CreateOrderModel(
        // table: table.value!,
        products: _products,
        userName: _userName.value,
        userPhone: _userPhone.value,
        userCep: _userCep.value,
        userRua: _userRua.value,
        userComplemento: _userComplemento.value,
      ));

      //  _products.clear();
      actions?.showSuccessMessage();
      actions?.goToPayment();
    } catch (e) {
      // print('Cart error $e');
      actions?.showErrorMessage();
    }

    loading.value = false;
  }

  Future<Map<String, dynamic>> index() async {
    var mp = MP('610069341879546', 'jZ7bKPbDoqDhjxLt9WRx0TRJqk1iwOFb');

    String? token = await mp.getAccessToken();

    //print('Mercadopago token $token');

    var preference = {
      "items": [
        {
          "title": "Test",
          "quantity": 1,
          "currency_id": "BR",
          "unit_price": 10.4
        }
      ]
    };

    var result = await mp.createPreference(preference);
    print(result);

    return result;
  }

  @override
  void dispose() {
    actions = null;
    super.dispose();
  }
}
