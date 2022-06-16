import 'package:flutter/material.dart';
import 'package:sampleflutter/helpers/sizeHelper.dart';
import 'package:sampleflutter/helpers/themeHelper.dart';

class GeneralTextField extends StatelessWidget {
  final Color? bgColor;
  final int? maxLines;
  final String title;

  final TextEditingController textEditingController;

  final BuildContext context;
  final FocusNode focusNode;
  final IconData iconData;
  final double? fieldWidth;
  final bool isObligated;
  final ValueKey? textFieldKey;
  final String? Function(String?)? validator;
  const GeneralTextField({
    Key? key,
    this.validator,
    this.bgColor,
    this.textFieldKey,
    required this.iconData,
    required this.title,
    required this.textEditingController,
    required this.context,
    this.fieldWidth,
    this.maxLines,
    this.isObligated = true,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = ThemeHelper();
    SizeHelper sizeHelper = SizeHelper();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: fieldWidth ?? sizeHelper.width! * 0.4,
        decoration: BoxDecoration(
          color: bgColor?.withOpacity(0.6) ?? themeHelper.primaryColor.withOpacity(0.6),
          border: Border.all(color: bgColor ?? themeHelper.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            key: textFieldKey,
            maxLines: maxLines,
            style: TextStyle(color: themeHelper.onPrimary),
            cursorColor: themeHelper.primaryColor,
            decoration: InputDecoration(
              labelText: title,
              errorStyle: TextStyle(color: Colors.red),
              labelStyle: TextStyle(color: Colors.black),
              suffixIcon: Icon(
                iconData,
                color: themeHelper.onBackgroundDark.withOpacity(0.8),
              ),
              border: InputBorder.none,
            ),
            focusNode: focusNode,
            onChanged: (String? changed) {},
            validator: validator ?? (input) {},
            controller: textEditingController,
          ),
        ),
      ),
    );
  }
}
