import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {required this.label,
      required this.hint,
      required this.controller,
      this.obscureText = false,
      this.readOnly = false,
      this.textInputType = TextInputType.text,
      this.suffix,
      this.onChanged,
      required this.validator,
      this.onSubmit,
      this.flex = 1,
      this.prefix,
      this.onTap,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0),
      this.maxLines = 1,
      this.width = 250,
      Key? key})
      : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final bool readOnly;
  final TextInputType textInputType;
  final Widget? suffix;
  final Function(String)? onChanged;
  final String? Function(String?) validator;
  final int flex;
  final Widget? prefix;
  final EdgeInsets padding;
  final Function(String)? onSubmit;
  final Function()? onTap;
  final EdgeInsets margin;
  final int maxLines;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Container(
        padding: padding,
        margin: margin,
        width: width,
        child: TextFormField(
          maxLines: maxLines,
          onTap: onTap,
          onFieldSubmitted: onSubmit,
          keyboardType: textInputType,
          readOnly: readOnly,
          obscureText: obscureText,
          validator: validator,
          style: Theme.of(context).textTheme.bodyText1,
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            suffix: suffix,
            hintText: hint,
            helperMaxLines: 3,
            prefix: prefix,
            hintStyle: Theme.of(context).textTheme.bodyText1,
            labelStyle: Theme.of(context).textTheme.bodyText1,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ).applyDefaults(Theme.of(context).inputDecorationTheme),
        ),
      ),
    );
  }
}
