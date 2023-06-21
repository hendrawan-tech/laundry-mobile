import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/ShimmerWidget.dart';

class ImageWidget extends StatelessWidget {
  final String image;
  final double? width, height, widthSvg, heightSvg;
  final EdgeInsets? margin, padding;
  final bool overlayImage;
  final BoxFit fit;
  final Alignment alignment;

  const ImageWidget({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.widthSvg,
    this.heightSvg,
    this.margin,
    this.padding,
    this.overlayImage = false,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = width ?? MediaQuery.of(context).size.width;
    double h = height ?? 0;
    double check = w < h ? w : h;

    return Container(
      margin: margin ?? const EdgeInsets.all(0),
      padding: padding ?? const EdgeInsets.all(0),
      child: Stack(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: image.contains('assets/svg')
                ? SvgPicture.asset(
                    image,
                    width: widthSvg,
                    height: heightSvg,
                    fit: BoxFit.contain,
                    alignment: alignment,
                  )
                : image.indexOf('http') == 0
                    ? CachedNetworkImage(
                        width: width,
                        height: height,
                        imageUrl: image,
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.maxFinite,
                            child: ShimmeerWidget(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                            child: Icon(
                          Icons.error,
                          color: whiteColor,
                        )),
                        fit: fit,
                        alignment: alignment,
                      )
                    : Image.asset(
                        image,
                        width: width,
                        height: height,
                        fit: fit,
                        alignment: alignment,
                      ),
          ),
        ],
      ),
    );
  }
}
