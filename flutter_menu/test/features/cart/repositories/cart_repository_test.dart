import 'package:flutter_menu/features/cart/models/create_order_model.dart';
import 'package:flutter_menu/features/cart/repositories/cart_repository.dart';
import 'package:flutter_menu/features/core/datasources/strapi_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class StrapiDatasourceMock extends Mock implements StrapiDatasource {}

class OrderFake extends Fake implements CreateOrderModel {}

void main() {
  late StrapiDatasource datasource;
  late CartRepository cartRepository;

  setUpAll(() {
    registerFallbackValue(OrderFake());
  });

  setUp(() {
    datasource = StrapiDatasourceMock();
    cartRepository = CartRepository(datasource);
  });

  group('testes de cenários de sucesso', () {
    const order = CreateOrderModel(
      table: '1',
      products: [],
      userPhone: '123',
      userName: '123',
    );

    setUp(() {
      when(() => datasource.createOrder(order)).thenAnswer((_) async => 1);
    });

    test('deve retornar o id do pedido quando realizado com sucesso', () async {
      // Act
      final result = await cartRepository.createOrder(order);

      // Assert
      expect(result, 1);
      verify(() => datasource.createOrder(order)).called(1);
    });
  });

  group('testes de cenários de erro', () {
    test('deve retornar uma exception caso dê erro na criação do pedido', () async {
      // Arrange
      const order = CreateOrderModel(
        table: '1',
        products: [],
        userPhone: '123',
        userName: '123',
      );
      when(() => datasource.createOrder(order)).thenThrow(Exception());

      // Act e Assert
      expect(() => cartRepository.createOrder(order), throwsA(isA<Exception>()));
    });
  });
}
