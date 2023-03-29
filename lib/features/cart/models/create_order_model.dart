import 'package:equatable/equatable.dart';
import 'package:flutter_menu/core/extensions/num_extension.dart';
import 'package:flutter_menu/features/product/models/product.dart';

class CreateOrderModel extends Equatable {
  const CreateOrderModel({
    required this.products,
    required this.userPhone,
    required this.userName,
    required this.userCep,
    required this.userRua,
    this.userComplemento,
  });

  //final String table;
  final List<Product> products;
  final String userName;
  final String userPhone;
  final String userCep;
  final String userRua;
  final String? userComplemento;

  Map<String, dynamic> toJson() {
    return {
      // 'table': table,
      'totalPrice': products
          .fold(0.0, (previousValue, element) => previousValue + element.total)
          .truncateFixed(2),
      'clientName': userName,
      'clientPhone': userPhone,
      'clientCep': userRua,
      'clientRua': userRua,
      'clientComplemento': userComplemento,
      'products': [
        for (final p in products)
          {
            'product': p.id,
            'basePrice': p.basePrice,
            'totalPrice': p.total.truncateFixed(2),
            'modifiers': [
              for (final m
                  in p.modifiers.where((m) => m.selectedOptions.isNotEmpty))
                for (final option in m.selectedOptions)
                  {
                    'title': '${m.info.title} - ${option.title}',
                    'price': option.total.truncateFixed(2),
                  }
            ]
          }
      ],
    };
  }

  @override
  List<Object?> get props => [products, userName, userPhone, userCep];
}
