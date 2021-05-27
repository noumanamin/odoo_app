import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero({
    Key? key,
    this.photo,
    this.onTap,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  final String? photo;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? color;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Hero(
        tag: photo!,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: SvgPicture.asset(
              photo!,
              fit: BoxFit.contain,
              color: color ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
