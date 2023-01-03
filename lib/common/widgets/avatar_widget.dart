import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  AvatarX(this.avatarUrl, {Key? key, this.size, this.radius, this.isCircle = true,this.defaultAvatar}) : super(key: key);

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
      backgroundImage: AssetImage(defaultAvatar??Assets.imagesDefaultAvatar),
      radius: this.radius ?? 40,
      foregroundImage: (avatarUrl != null && avatarUrl!.isNotEmpty) ? NetworkImage(avatarUrl!) : null,
    );
  }

  Widget _normal() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(this.radius ?? 8.r),
      child: Stack(
        children: [
          Image.asset(defaultAvatar??Assets.svgDefaultAvatar,width: size??defaultSize.w,height: size??defaultSize.w,fit: BoxFit.cover),
          Container(
            height: this.size ?? defaultSize.w,
            width: this.size ?? defaultSize.w,
            child: ImageHelper.network(this.avatarUrl,fit: BoxFit.cover,),
          )
        ],
      ),
    );
  }
}
