import 'package:flutter_menu/features/cart/controllers/cart_controller.dart';
import 'package:flutter_menu/features/cart/models/create_order_model.dart';
import 'package:flutter_menu/features/cart/pages/cart/cart_page_actions.dart';
import 'package:flutter_menu/features/cart/repositories/cart_repository.dart';
import 'package:flutter_menu/features/product/models/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../repositories/cart_repository_test.dart';

class CartRepositoryMock extends Mock implements CartRepository {}

class CartPageActionsMock extends Mock implements CartPageActions {}

class NotifyListenersMock extends Mock {
  void call();
}

void main() {
  late CartRepository cartRepository;
  late CartPageActions actions;
  late NotifyListenersMock notifyListeners;
  late CartController controller;

  const product = Product(
    id: 1,
    title: 'Teste',
    description: 'Teste',
    originalBasePrice: 10,
    basePrice: 12,
    imageUrl: '',
    category: null,
    modifiers: [],
    quantity: 3,
  );

  setUpAll(() {
    registerFallbackValue(OrderFake());
  });

  setUp(() {
    cartRepository = CartRepositoryMock();
    actions = CartPageActionsMock();
    notifyListeners = NotifyListenersMock();
    controller =
        CartController(cartRepository: cartRepository, actions: actions);

    controller.addListener(notifyListeners);
  });

  tearDown(() {
    controller.removeListener(notifyListeners);
  });

  group('testes na listagem de produtos', () {
    test('deve adicionar um produto na lista de produtos ao chamar addProduct',
        () {
      controller.addProduct(product);

      expect(controller.products.length, 1);
      expect(controller.products, contains(product));
      verify(() => notifyListeners()).called(1);
    });

    test('deve remover um produto na lista de produtos ao chamar removeProduct',
        () {
      controller.addProduct(product);

      controller.removeProduct(product);

      expect(controller.products, isEmpty);
      verify(() => notifyListeners()).called(2);
    });

    test('deve retornar a quantidade total de produtos no productCount', () {
      controller.addProduct(product);
      expect(controller.productCount, 1);

      controller.addProduct(product);
      expect(controller.productCount, 2);
    });
  });

  group('testes dos calculos do carrinho', () {
    test('deve retornar o custo total do carrinho no totalPrice', () {
      controller.addProduct(product);
      expect(controller.totalPrice, 12);

      controller.addProduct(product);
      expect(controller.totalPrice, 24);
    });
  });

  group('testes do formulário do usuário', () {
    test(
        'deve retornar true no isFormValid caso o nome e telefone sejam válidos',
        () {
      controller.setUserName('Daniel');
      controller.setUserPhone('(11) 91234-5678');

      expect(controller.userName, 'Daniel');
      expect(controller.userPhone, '(11) 91234-5678');
      expect(controller.isFormValid, isTrue);
      verify(() => notifyListeners()).called(2);
    });

    test(
        'deve retornar false no isFormValid caso o nome e/ou telefone sejam inválidos',
        () {
      controller.setUserName('Da');
      controller.setUserPhone('(11) 91234-5678');
      expect(controller.isFormValid, isFalse);

      controller.setUserName('Daniel');
      controller.setUserPhone('(11) 91234-');
      expect(controller.isFormValid, isFalse);

      verify(() => notifyListeners()).called(4);
    });
  });

  test(
      'em caso de sucesso na criação de pedido, deve limpar o carrinho e redirecionar para a home',
      () async {
    const order = CreateOrderModel(
        // table: '1',
        products: [product],
        userName: 'Daniel',
        userPhone: '123',
        userCep: 'dd',
        userRua: '');

    when(() => cartRepository.createOrder(order)).thenAnswer((_) async => 1);

    controller.addProduct(product);
    controller.setTable('1');
    controller.setUserName('Daniel');
    controller.setUserPhone('123');
    verify(() => notifyListeners()).called(3);

    await controller.sendOrder();

    expect(controller.products, isEmpty);
    expect(controller.loading, isFalse);
    verify(() => actions.goToHome()).called(1);
    verify(() => notifyListeners()).called(2);
    verifyNoMoreInteractions(actions);
  });

  test(
      'deve exibir uma mensagem de erro e manter o carrinho intacto caso de erro na criação do pedido',
      () async {
    when(() => cartRepository.createOrder(any())).thenThrow(Exception());

    controller.addProduct(product);
    controller.setTable('1');
    verify(() => notifyListeners()).called(1);

    await controller.sendOrder();

    expect(controller.products, contains(product));
    expect(controller.loading, isFalse);
    verify(() => actions.showErrorMessage()).called(1);
    verify(() => notifyListeners()).called(2);
    verifyNoMoreInteractions(actions);
  });

  test('deve colocar actions como null ao dar dispose', () {
    controller.dispose();

    expect(controller.actions, isNull);
  });
}
