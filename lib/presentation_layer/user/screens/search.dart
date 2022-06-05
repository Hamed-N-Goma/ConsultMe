import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          cursorColor: ColorManager.myBlue,
          onTap: () {},
          onFieldSubmitted: (value) {},
          decoration: const InputDecoration(
              fillColor: ColorManager.myBlue,
              prefixIcon: Icon(
                FontAwesomeIcons.magnifyingGlass,
              ),
              labelText: 'بحث',
              border: OutlineInputBorder()),
        ),
      ],
    );
  }
}
