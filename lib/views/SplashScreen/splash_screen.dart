import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes/routes_names.dart';
import '../../core/constants/app_assets.dart';
import 'components/splash_content_overlay.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMainScreen();
  }

  Future<void> _navigateToMainScreen() async {
    await Future.delayed(Duration(seconds: 2));
    if (mounted) {
      context.go(RoutesName.mainScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.images.splash,
            fit: BoxFit.cover,
          ),
          SplashContentOverlay(),
        ],
      ),
    );
  }
}
