import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_text/link_text.dart';



class TechnicalSupportScreen extends StatelessWidget {
  const TechnicalSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 12.0,
          title: Text(
            "الدعم الفنى",
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8.0),
              child: Container(
                padding: const EdgeInsets.all(0.0),
                width: 34.0,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    'assets/images/back_arrow.svg',
                    width: 18.0,
                    height: 18.0,
                    color: ThemeCubit.get(context).darkTheme? mainTextColor : mainColors,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'للتواصل مع المطورين',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                const SizedBox(height:5.0),
                Container(
                  width: 250.0,
                  height:1.0,
                  color: separator,
                ),
                const SizedBox(height: 10.0,),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SelectableText(
                    '092-5733263',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SelectableText(
                    '091-0610980',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(height: 30.0,),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'للتواصل مع المشرف',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                const SizedBox(height:5.0),
                Container(
                  width: 250.0,
                  height:1.0,
                  color: separator,
                ),
                const SizedBox(height: 10.0,),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SelectableText(
                    '011111111111',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SelectableText(
                    '011111111111',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(height: 30.0,),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'للتواصل مع إدارة القسم',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                const SizedBox(height:5.0),
                Container(
                  width: 250.0,
                  height:1.0,
                  color: separator,
                ),
                const SizedBox(height: 10.0,),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: LinkText(
                    'http://uot.edu.ly/SoftwareEng',
                    onLinkTap: (url){
                     // navigateTo(context, WebViewScreen(url));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

