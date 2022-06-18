import 'package:consultme/components/components.dart';
import 'package:consultme/models/PostModel.dart';
import 'package:flutter/material.dart';

class PostsDetails extends StatelessWidget {
  final PostModel post;
  PostsDetails({Key? key, required this.post}) : super(key: key);
  var height, width, size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          image: DecorationImage(
                              image: NetworkImage(post.image!),
                              fit: BoxFit.cover)),
                      height: height * 0.4,
                      width: double.infinity,
                    ),
                  ],
                ),
                Positioned(
                  top: height * 0.3,
                  child: SingleChildScrollView(
                    child: Material(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: Container(
                        clipBehavior: Clip.none,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        width: width,
                        height: height * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 30, 10, 0.8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    post.title!,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  post.text!,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        buildCustomText(
                                            text: 'الناشر:',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        buildCustomText(
                                            text: post.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        buildCustomText(
                                            text: 'تاريخ النشر :',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        buildCustomText(
                                            text: post.dateTime!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
