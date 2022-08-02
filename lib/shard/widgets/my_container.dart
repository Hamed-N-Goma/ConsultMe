import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    Key? key,
    this.width = double.infinity,
    this.height,
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.all(8),
    this.boxDecoration = const BoxDecoration(),
    this.backgroundColor,
    this.shadow = false,
    required this.child,
    this.alignment,
  }) : super(key: key);

  final double? width;
  final double? height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BoxDecoration boxDecoration;
  final Widget child;
  final Color? backgroundColor;
  final bool shadow;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: alignment,
      margin: margin,
      padding: padding,
      decoration: boxDecoration.copyWith(
        borderRadius: BorderRadius.circular(5),
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 0),
                ),
              ]
            : null,
        color: backgroundColor ?? Theme.of(context).backgroundColor,
      ),
      child: child,
    );
  }
}
