import 'package:flutter/material.dart';

class GradientText extends StatefulWidget {
  final double? fontSize;
  final FontWeight? fontWeight;
  final String text;
  final List<Color>? colors;
  const GradientText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.colors});

  @override
  State<GradientText> createState() => _GradientTextState();
}

class _GradientTextState extends State<GradientText> {
  GlobalKey myTextKey = GlobalKey();
  RenderBox? myTextRenderBox;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _recordSize());
  }

  void _recordSize() {
    setState(() {
      myTextRenderBox =
          myTextKey.currentContext?.findRenderObject() as RenderBox;
    });
  }

  Shader getTextGradient(RenderBox renderBox) {
    return LinearGradient(
      colors: widget.colors ??
          const <Color>[
            Color(0xffD5BE88),
            Color(0xffF3EDA6),
            Color(0xffF8FAE5),
            Color(0xffFFE2BE),
            Color(0xffD5BE88),
            Color(0xffF8FAE5),
            Color(0xffD5BE88),
          ],
    ).createShader(Rect.fromLTWH(
        renderBox.localToGlobal(Offset.zero).dx,
        renderBox.localToGlobal(Offset.zero).dy,
        renderBox.size.width,
        renderBox.size.height));
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      key: myTextKey,
      style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          foreground: Paint()
            ..shader = myTextRenderBox == null
                ? null
                : getTextGradient(myTextRenderBox!)),
    );
  }
}
