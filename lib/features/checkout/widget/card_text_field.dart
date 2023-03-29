import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';

class CardTextField extends StatelessWidget {
  final String title;
  final bool bold;
  final String hint;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormaters;
  final FormFieldValidator<String> validator;
  final int maxLenght;
  final TextAlign textAlign;
  final FocusNode focusNode;
  final Function(String) onSubmitted;
//  final FormFieldSetter<String> onSaved;
  final Function(String) onChanged;
  // final TextInputAction textInputAction;

  const CardTextField(
      {Key? key,
      this.title = '',
      this.bold = false,
      // required this.onSaved,
      required this.hint,
      required this.textInputType,
      required this.inputFormaters,
      required this.validator,
      required this.maxLenght,
      this.textAlign = TextAlign.start,
      required this.focusNode,
      required this.onSubmitted,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: '',
      //  onSaved: onSaved,
      validator: validator,

      builder: (state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title.isNotEmpty)
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: state.hasError
                            ? Colors.red
                            : ColorsTheme.kPrimaryColor,
                      ),
                    ),
                    if (state.hasError)
                      const Text(
                        ' - Inválido',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                  ],
                ),
              TextFormField(
                //    onSaved: onSaved,
                cursorColor: ColorsTheme.kBackgroundColor,

                style: TextStyle(
                  color: title.isNotEmpty && state.hasError
                      ? Colors.red
                      : ColorsTheme.kPrimaryColor,
                  fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: title.isEmpty && state.hasError
                        ? Colors.red.withAlpha(200)
                        : Colors.white.withAlpha(100),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  counterText: '',
                ),
                keyboardType: textInputType,
                inputFormatters: inputFormaters,
                onChanged: onChanged,
                maxLength: maxLenght,
                textAlign: textAlign,
                focusNode: focusNode,
                onFieldSubmitted: onSubmitted,
              ),
            ],
          ),
        );
      },
    );
  }
}
