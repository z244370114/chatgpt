import 'package:flutter/material.dart';


const String svgFormat = "svg";

class ImgUtil {
  static ImageProvider getAssetImage(String name, {String format = 'png'}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

// static ImageProvider getImageProvider(String imageUrl,
//     {String holderImg = 'no_picture'}) {
//   if (TextUtil.isEmpty(imageUrl)) {
//     return AssetImage(getImgPath(holderImg));
//   }
//   return CachedNetworkImageProvider(
//     imageUrl,
//   );
// }
}
