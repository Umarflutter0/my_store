import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';

class SplashImage extends StatelessWidget {
  const SplashImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.images.splash,
      fit: BoxFit.cover,
    );
  }
}
