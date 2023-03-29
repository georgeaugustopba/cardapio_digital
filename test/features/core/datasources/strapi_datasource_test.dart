import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_menu/features/core/datasources/strapi_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late Dio dio;
  late StrapiDatasource datasource;

  setUp(() {
    dio = DioMock();
    datasource = StrapiDatasourceImpl(dio);
  });

  group('testes do getProduct', () {
    test('deve retornar um model product quando sucesso', () async {
      // Arrange
      when(() => dio.get('/products/5', queryParameters: {'populate': 'deep'}))
          .thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: jsonDecode(File('test/fixtures/get_product_response.json')
              .readAsStringSync()),
          statusCode: 200,
        ),
      );

      // Act
      final result = await datasource.getProduct(5);

      // Assert
      expect(result.isRight, isTrue);
    });

    test('deve retornar notFound caso o produto não exista', () async {
      when(() => dio.get('/products/5', queryParameters: {'populate': 'deep'}))
          .thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          type: DioErrorType.response,
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );

      final result = await datasource.getProduct(5);

      expect(result.isLeft, isTrue);
      expect(result.left, GetProductError.notFound);
    });

    test('deve retornar unknownError caso dê um erro inesperado', () async {
      when(() => dio.get('/products/5', queryParameters: {'populate': 'deep'}))
          .thenThrow(Exception());

      final result = await datasource.getProduct(5);

      expect(result.isLeft, isTrue);
      expect(result.left, GetProductError.unknownError);
    });
  });
}
