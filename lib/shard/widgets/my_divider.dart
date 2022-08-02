import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
    this.indent = 0,
    this.endIndent = 0,
    this.height = 5,
    this.thickness = 1,
  }) : super(key: key);
  final double indent;
  final double endIndent;
  final double height;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).dividerColor,
      thickness: thickness,
      height: height,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
