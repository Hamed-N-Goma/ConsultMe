import 'package:flutter/material.dart';
import 'package:consultme/shard/widgets/my_icon_button.dart';

class MySearchField extends StatelessWidget {
  const MySearchField(
      {required this.label,
      required this.hint,
      required this.controller,
      this.obscureText = false,
      this.readOnly = false,
      this.textInputType = TextInputType.text,
      this.suffix,
      this.onChanged,
      this.flex = 1,
      this.prefix,
      this.onTap,
      this.onSubmit,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.symmetric(horizontal: 16),
      this.maxLines = 1,
      this.width = double.infinity,
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
  final int flex;
  final Widget? prefix;
  final EdgeInsets padding;
  final Function()? onTap;
  final Function(String)? onSubmit;
  final EdgeInsets margin;
  final int maxLines;
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: maxLines,
              onTap: onTap,
              onSubmitted: onSubmit,
              keyboardType: textInputType,
              readOnly: readOnly,
              obscureText: obscureText,
              style: theme.textTheme.bodyText1,
              onChanged: onChanged,
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                suffix: suffix,
                hintText: hint,
                prefix: prefix,
                hintStyle: theme.textTheme.bodyText1,
                labelStyle: theme.textTheme.bodyText1,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius:
                      Localizations.localeOf(context).languageCode != 'ar'
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))
                          : const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                    width: 1,
                  ),
                  borderRadius:
                      Localizations.localeOf(context).languageCode != 'ar'
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))
                          : const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                ),
              ).applyDefaults(theme.inputDecorationTheme),
            ),
          ),
          MyIconButton(
            color: theme.primaryColor,
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
            borderRadius: Localizations.localeOf(context).languageCode == 'ar'
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))
                : const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
          ),
        ],
      ),
    );
  }
}
