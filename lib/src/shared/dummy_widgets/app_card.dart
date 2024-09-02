import 'package:flutter/material.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';

class AppCard extends StatelessWidget {
  final bool? selected;
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;
  final double? radius;
  final BoxConstraints? constraints;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final DecorationImage? image;

  const AppCard(
      {super.key,
      this.selected = false,
      this.borderWidth,
      required this.child,
      this.color,
      this.borderColor,
      this.radius,
      this.constraints,
      this.width,
      this.height,
      this.padding,
      this.image});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: constraints,
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color ?? context.theme.cardColor,
          borderRadius: BorderRadius.circular(radius ?? 16),
          border: selected!
              ? Border.all(
                  color: borderColor ?? context.theme.hoverColor,
                  width: borderWidth ?? 2)
              : Border.all(
                  color: color ?? context.theme.cardColor,
                  width: borderWidth ?? 2),
          image: image),
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );
  }
}

class ImageCover extends StatelessWidget {
  final String image;
  final Widget child;
  final double height;
  const ImageCover({
    super.key,
    required this.image,
    required this.child,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(50, 150, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
