class AppAssets {
  static final Images images = Images();
  static final AppIcons icons = AppIcons();
}

// Public class for image paths
class Images {
  final String splash = 'assets/images/splash.png';
  final String img = 'assets/images/img.png';
}

// Public class for icon paths
class AppIcons {
  final String category = 'assets/icons/category.svg';
  final String favourite = 'assets/icons/favourite.svg';
  final String product = 'assets/icons/pro.svg';
  final String profile = 'assets/icons/profile.svg';

  // Use a getter to avoid initialization issues
  List<String> get navbarIcons => [
        product,
        category,
        favourite,
        profile,
      ];
}
