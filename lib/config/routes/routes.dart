import 'package:go_router/go_router.dart';
import 'package:test/config/routes/routes_names.dart';

import '../../models/product_model.dart';
import '../../views/CategoriesScreen/product_from_categories.dart';
import '../../views/MainScreen/main_screen.dart';
import '../../views/ProductsScreen/product_details_screen.dart';
import '../../views/ProductsScreen/products_screen.dart';
import '../../views/SplashScreen/splash_screen.dart';

final GoRouter routes = GoRouter(
  initialLocation: RoutesName.splashScreen,
  routes: [
    GoRoute(
      path: RoutesName.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutesName.mainScreen,
      builder: (context, state) => MainScreen(),
    ),
    GoRoute(
      path: RoutesName.productsScreen,
      builder: (context, state) {
        final map = state.extra as Map<String, dynamic>;
        return ProductsScreen(
          values: {
            'endPoint': map['url'],
            'category': map['category'],
          },
        );
      },
    ),
    GoRoute(
      path: RoutesName.productsFromCategoriesS,
      builder: (context, state) {
        final map = state.extra as Map<String, dynamic>;
        return ProductsFromCategoriesS(
          values: {
            'endPoint': map['url'],
            'category': map['category'],
          },
        );
      },
    ),
    GoRoute(
      path: RoutesName.productDetails,
      builder: (context, state) {
        final product =
            state.extra as ProductModel; // Cast extra to ProductModel
        return ProductDetailsScreen(product: product); // Pass product to screen
      },
    ),
  ],
);
