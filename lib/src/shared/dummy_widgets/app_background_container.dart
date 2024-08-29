import 'package:flutter/material.dart';

class AppBackgroundContainer extends StatelessWidget {
  final Widget child;
  const AppBackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
            colors: [
              Color(0xff1F4247),
              Color(0xff0D1D23),
            ],
            center: Alignment(0.9, -0.6),
            radius: 1,
            stops: [0.4, 1.0]),
      ),
      child: SafeArea(child: child),
    );
  }
}
