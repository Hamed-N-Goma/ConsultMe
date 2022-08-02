import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.width = 50,
    this.height = 50,
    this.hoverColor,
    this.color,
    this.textStyle,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.isRounded = false,
    this.borderColor,
    this.border = false,
  }) : super(key: key);

  final Function()? onPressed;
  final Widget icon;
  final Color? hoverColor;
  final Color? color;
  final double width;
  final double height;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BorderRadiusGeometry borderRadius;
  final bool isRounded;
  final Color? borderColor;
  final bool border;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: border
          ? BoxDecoration(
              border: Border.all(
                color: borderColor ?? Theme.of(context).dividerColor,
              ),
              borderRadius: isRounded
                  ? const BorderRadius.all(Radius.circular(25))
                  : borderRadius,
            )
          : null,
      child: TextButton(
        onPressed: onPressed,
        style: Theme.of(context).textButtonTheme.style!.copyWith(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: MaterialStateProperty.all(
                isRounded
                    ? const CircleBorder()
                    : RoundedRectangleBorder(
                        borderRadius: borderRadius,
                      ),
              ),
              overlayColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.hovered)) {
                    return hoverColor != null
                        ? hoverColor!.withOpacity(0.2)
                        : borderColor == null
                            ? color == null
                                ? theme.primaryColor.withOpacity(.2)
                                : color!.withOpacity(0.2)
                            : borderColor!.withOpacity(.2);
                  }
                  if (states.contains(MaterialState.pressed)) {
                    return hoverColor != null
                        ? hoverColor!.withOpacity(0.4)
                        : borderColor == null
                            ? color == null
                                ? theme.primaryColor.withOpacity(.4)
                                : color!.withOpacity(0.4)
                            : borderColor!.withOpacity(.4);
                  }
                  return color ?? Theme.of(context).primaryColor;
                },
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.transparent;
                  }
                  return color ?? Colors.white.withOpacity(0.2);
                },
              ),
            ),
        child: icon,
      ),
    );
  }
}
