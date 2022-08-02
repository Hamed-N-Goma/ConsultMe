import 'package:flutter/material.dart';
import 'package:consultme/shard/widgets/loading.dart';

Future floatingLoading(BuildContext context) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return const Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Loading(),
      );
    },
  );
}
