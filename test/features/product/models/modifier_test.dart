import 'package:flutter_menu/features/product/models/modifier.dart';
import 'package:flutter_menu/features/product/models/modifier_info.dart';
import 'package:flutter_menu/features/product/models/modifiers/simple_modifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Modifier modifier;

  final modifierInfo = ModifierInfo(
    title: '',
    allowRepeated: false,
    minQuantity: 1,
    maxQuantity: null,
  );

  test(
      'caso o modifier não permita repetição, não deve incluir um item já existente na lista',
      () {
    modifier = SimpleModifier.forTest(info: modifierInfo);

    modifier.addItem(const SimpleModifierOption(title: ''));
    modifier.addItem(const SimpleModifierOption(title: ''));

    expect(modifier.selectedOptions.length, 1);
  });

  test(
      'caso o modifier permita repetição, deve incluir um item já existente na lista',
      () {
    modifier = SimpleModifier.forTest(info: modifierInfo.copyWith(allowRepeated: true));

    modifier.addItem(const SimpleModifierOption(title: ''));
    modifier.addItem(const SimpleModifierOption(title: ''));

    expect(modifier.selectedOptions.length, 2);
  });

  test(
      'caso o modifier permita apenas 1 item, deve incluir o novo e excluir os existentes',
      () {
    modifier = SimpleModifier.forTest(info: modifierInfo.copyWith(maxQuantity: 1));

    modifier.addItem(const SimpleModifierOption(title: 'A'));
    modifier.addItem(const SimpleModifierOption(title: 'B'));

    expect(modifier.selectedOptions.length, 1);
    expect(modifier.selectedOptions,
        contains(const SimpleModifierOption(title: 'B')));
  });

  test(
      'caso o modifier permita mais de 1 item, deve incluir o novo e manter os existentes',
      () {
    modifier = SimpleModifier.forTest(info: modifierInfo.copyWith(maxQuantity: 3));

    modifier.addItem(const SimpleModifierOption(title: 'A'));
    modifier.addItem(const SimpleModifierOption(title: 'B'));

    expect(modifier.selectedOptions.length, 2);
  });

  test('deve retornar false no canAddItem caso eu já tenha atingido a máxima quantidade', () {
    modifier = SimpleModifier.forTest(info: modifierInfo.copyWith(maxQuantity: 1));

    modifier.addItem(const SimpleModifierOption(title: 'A'));

    expect(modifier.canAddItem, isFalse);
  });

  test('deve retornar true no canAddItem caso não tenha uma quantidade limite de itens', () {
    modifier = SimpleModifier.forTest(info: modifierInfo);

    modifier.addItem(const SimpleModifierOption(title: 'A'));

    expect(modifier.canAddItem, isTrue);
  });
}
