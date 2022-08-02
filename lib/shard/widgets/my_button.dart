import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.width = double.infinity,
    this.height = 45,
    this.hoverColor,
    this.color,
    this.textStyle,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.leading,
    this.borderColor,
    this.border = false,
  }) : super(key: key);

  final Function()? onPressed;
  final Widget? icon;
  final Color? hoverColor;
  final Color? color;
  final double width;
  final double height;
  final String text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Widget? leading;
  final Color? borderColor;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: border
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: borderColor ?? Theme.of(context).dividerColor,
              ),
            )
          : null,
      child: TextButton(
        onPressed: onPressed,
        style: Theme.of(context).textButtonTheme.style!.copyWith(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              overlayColor: MaterialStateProperty.all(
                  color == Colors.transparent
                      ? Theme.of(context).primaryColor.withOpacity(.2)
                      : Colors.white.withOpacity(.2)),
              minimumSize: MaterialStateProperty.all(Size(width, height)),
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.hovered) ||
                      states.contains(MaterialState.selected)) {
                    return hoverColor != null
                        ? hoverColor!.withOpacity(0.2)
                        : Theme.of(context).primaryColor.withOpacity(0.2);
                  }
                  return color ?? Theme.of(context).primaryColor;
                },
              ),
            ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading == null
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: leading,
                  ),
            Flexible(
              child: Text(
                text,
                style: textStyle ??
                    Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: color == Colors.transparent
                              ? mainColors
                              : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                textAlign: TextAlign.center,
              ),
            ),
            icon == null
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: icon,
                  ),
          ],
        ),
      ),
    );
  }
}
