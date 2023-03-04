import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svgProvider;

import '../../generated/assets.dart';
import '../utils/image_helper.dart';

// ignore: must_be_immutable
class AvatarX extends StatelessWidget {
  String? avatarUrl;
  String? defaultAvatar;
  double? size;
  double? radius;
  bool isCircle;

  double defaultSize = 80;

  AvatarX(this.avatarUrl, {Key? key, this.size, this.radius, this.isCircle = true, this.defaultAvatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.size ?? defaultSize.w,
      width: this.size ?? defaultSize.w,
      child: this.isCircle ? _circle() : _normal(),
    );
  }

  Widget _circle() {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: (avatarUrl != null && avatarUrl!.isNotEmpty) ? null : AssetImage(defaultAvatar ?? Assets.imagesDefaultAvatar),
      radius: this.radius ?? 40,
      foregroundImage: (avatarUrl != null && avatarUrl!.isNotEmpty) ? _circleImage(avatarUrl!) : null,
    );
  }

  Widget _normal() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(this.radius ?? 8.r),
      child: Stack(
        children: [
          (avatarUrl != null && avatarUrl!.isNotEmpty)
              ? SizedBox()
              : Image.asset(defaultAvatar ?? Assets.svgDefaultAvatar, width: size ?? defaultSize.w, height: size ?? defaultSize.w, fit: BoxFit.cover),
          (avatarUrl == null || avatarUrl!.isEmpty)
              ? SizedBox()
              : Container(
                  height: this.size ?? defaultSize.w,
                  width: this.size ?? defaultSize.w,
                  child: _normalImage(avatarUrl!),
                )
        ],
      ),
    );
  }

  ImageProvider _circleImage(String url) {
    if (url.endsWith('svg')) {
      return svgProvider.Svg(url, size: Size(size ?? defaultSize.w, size ?? defaultSize.w));
    } else {
      return NetworkImage(avatarUrl!);
    }
  }

  Widget _normalImage(String url) {
    if (url.endsWith('svg')) {
      return SvgPicture.network(url, width: size ?? defaultSize.w);
    } else {
      return ImageHelper.network(
        this.avatarUrl,
        fit: BoxFit.cover,
      );
    }
  }
}
