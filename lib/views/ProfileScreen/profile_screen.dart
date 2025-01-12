import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../providers/BottomNavProvider/bottom_nav_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<BottomNavProvider>(
        builder: (context, provider, child) {
          return Text(
            AppStrings.navbarItems[provider.selectedIndex],
          );
        },
      ),
    );
  }
}
