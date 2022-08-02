import 'package:flutter/material.dart';

class BulletList extends StatelessWidget {
  const BulletList(this.texts, {Key? key}) : super(key: key);
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      widgetList.add(BulletListItem(text));
      widgetList.add(const SizedBox(height: 5.0));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgetList,
      ),
    );
  }
}

class BulletListItem extends StatelessWidget {
  const BulletListItem(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "\u2022 ",
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
