import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stockflow/screens/auth/forgot_password_screen.dart';
import 'package:stockflow/screens/auth/logout_screen.dart';
import 'package:stockflow/screens/auth/register_screen.dart';
import 'package:stockflow/screens/auth/welcome_screen.dart';
import 'package:stockflow/screens/customer/add_edit_customer_screen.dart';
import 'package:stockflow/screens/customer/customer_detail_screen.dart';
import 'package:stockflow/screens/customer/customer_list_screen.dart';
import 'package:stockflow/screens/inventory/add_movement_screen.dart';
import 'package:stockflow/screens/settings/profile_screen.dart';

// Import de vos écrans (Adaptez les chemins selon votre projet)
import '../providers/user_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/enterprise/add_edit_enterprise_screen.dart';
import '../screens/enterprise/enterprise_list_screen.dart';
import '../screens/inventory/alerts_screen.dart';
import '../screens/inventory/movement_list_screen.dart';
import '../screens/layout/layout.dart';
import '../screens/order/add_edit_order_screen.dart';
import '../screens/order/order_detail_screen.dart';
import '../screens/order/order_list_screen.dart';
import '../screens/products/add_edit_product_screen.dart';
import '../screens/products/category_management_screen.dart';
import '../screens/products/product_detail_screen.dart';
import '../screens/products/product_list_screen.dart';
import '../screens/settings/add_edit_user_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/user_management_screen.dart';
import '../screens/supplier/add_edit_supplier_screen.dart';
import '../screens/supplier/supplier_list_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Surveillance de l'utilisateur pour la garde de navigation
  final authState = ref.watch(selectedUserProvider);

  return GoRouter(
    initialLocation: '/dashboard',
    // Garde de navigation : vérifie selectedUser
    redirect: (context, state) {
      final isLoggedIn = authState != null;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoggingIn) return '/';
      if (isLoggedIn && isLoggingIn) return '/login';
      return null;
    },
    routes: [
      // Route hors Layout (Login)
      GoRoute(
        path: '/',
        builder: (context, state) => WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/logout',
        builder: (context, state) => LogoutScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => ForgotPasswordScreen(),
      ),

      // SETTINGS
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),GoRoute(
        path: '/profile-setting',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/user-management',
        builder: (context, state) => const UserManagementScreen(),
      ),

      // INVENTORY
      GoRoute(
        path: '/movements',
        builder: (context, state) => const MovementListScreen(),
      ),
      GoRoute(
        path: '/movement-alerts',
        builder: (context, state) => const AlertsScreen(),
      ),
      GoRoute(
        path: '/add-movement',
        builder: (context, state) => const AddMovementScreen(),
      ),

      // ENTERPRISES
      GoRoute(
        path: '/enterprises',
        builder: (context, state) => const ProductListScreen(),
      ),
      GoRoute(
        path: '/add-enterprise',
        builder: (context, state) => const AddEditEnterpriseScreen(),
      ),
      GoRoute(
        path: '/edit-enterprise/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return AddEditEnterpriseScreen(enterpriseId: id);
        },
      ),

      // SUPPLIERS
      GoRoute(
        path: '/suppliers',
        builder: (context, state) => const SupplierListScreen(),
      ),
      GoRoute(
        path: '/add-supplier',
        builder: (context, state) => const AddEditCustomerScreen(),
      ),
      GoRoute(
        path: '/edit-supplier/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return AddEditSupplierScreen(supplierId: id);
        },
      ),


      ShellRoute(
        builder: (context, state, child) {
          return Layout(child: child);
        },
        routes: [

          // DASHBOARD
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),

          // CUSTOMERS
          GoRoute(
            path: '/customers',
            builder: (context, state) => CustomerListScreen(), // ou CustomerList
          ),
          GoRoute(
            path: '/customer-detail/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return CustomerDetailScreen(customerId: id);
            },
          ),
          GoRoute(
            path: '/add-customer',
            builder: (context, state) => const AddEditCustomerScreen(),
          ),
          GoRoute(
            path: '/edit-customer/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return AddEditCustomerScreen(customerId: id);
            },
          ),

          // ORDERS
          GoRoute(
            path: '/orders',
            builder: (context, state) => const OrderListScreen(),
          ),
          GoRoute(
            path: '/order-detail/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return OrderDetailScreen(orderId: id);
            },
          ),
          GoRoute(
            path: '/add-order',
            builder: (context, state) => const AddEditOrderScreen(),
          ),
          GoRoute(
            path: '/edit-order/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return AddEditOrderScreen(orderId: id);
            },
          ),

          // PRODUCTS
          GoRoute(
            path: '/products',
            builder: (context, state) => const ProductListScreen(),
          ),
          GoRoute(
            path: '/product-detail/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return ProductDetailScreen(productId: id);
            },
          ),
          GoRoute(
            path: '/add-product',
            builder: (context, state) => const AddEditProductScreen(),
          ),
          GoRoute(
            path: '/edit-product/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return AddEditProductScreen(productId: id);
            },
          ),


        ],
      ),
    ],
  );
});
