import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test/config/routes/routes_names.dart';

import 'components/splash_content_overlay.dart';
import 'components/splash_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Future.delayed(Duration(seconds: 4));
      context.go(RoutesName.mainScreen);
    });
    return SafeArea(
      child: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          SplashImage(),
          SplashContentOverlay(),
        ],
      ),
    );
  }
}
