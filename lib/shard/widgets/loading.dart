import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.progress}) : super(key: key);
  final double? progress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
        strokeWidth: 4,
        value: progress,
        backgroundColor: Colors.white,
      ),
    );
  }
}
