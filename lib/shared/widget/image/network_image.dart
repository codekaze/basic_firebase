import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class ExImage extends StatelessWidget {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;

  ExImage(
    this.src, {
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      imageUrl: src,
      placeholder: (context, url) => Container(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 50.0,
          ),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );

    return FadeInImage(
      width: width,
      height: height,
      image: NetworkImage(src),
      placeholder: NetworkImage("https://i.ibb.co/Tgvg9Zy/3875172.png"),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.network("https://i.ibb.co/Tgvg9Zy/3875172.png");
      },
      fit: fit,
    );
    try {
      return Image.network(
        src,
        height: width,
        width: height,
        fit: fit,
        // loadingBuilder: (context, child, loadingProgress) =>
        //     ImageLoading.getDefaultLoadingBuilder(
        //   context,
        //   child,
        //   loadingProgress,
        // ),
        errorBuilder: (context, exception, stackTrace) {
          return CircleAvatar();
          return Container(
            child: Image.network(
              "https://cdn-icons.flaticon.com/png/128/3875/premium/3875172.png?token=exp=1644244061~hmac=aa86ea54c628a572753ba23bd2e9602a",
            ),
          );

          return Container(
            width: 100.0,
            height: 100.0,
            color: Colors.grey[400],
          );
          return Container(
            width: width,
            height: height,
            color: Colors.grey[400],
            child: Center(
              child: Text(
                "Error",
                style: TextStyle(
                  fontSize: 8.0,
                ),
              ),
            ),
          );
        },
      );
    } on Exception catch (_) {
      return CircleAvatar(
        backgroundColor: Colors.red,
      );
    }
  }
}
