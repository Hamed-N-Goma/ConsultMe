import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:consultme/shard/widgets/loading.dart';

class MyImage extends StatelessWidget {
  const MyImage(
      {Key? key, required this.url, this.height = 225, this.width = 225})
      : super(key: key);
  final String url;
  final double height;

  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.fill,
      matchTextDirection: true,
      height: height,
      progressIndicatorBuilder: (context, url, downloadProgress) => Loading(
        progress: downloadProgress.progress,
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text(
                'حدثت مشكلة أثناء تحميل الصورة',
                style: theme.textTheme.bodyText2!.copyWith(
                  color: theme.primaryColor,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
