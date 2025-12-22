import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockflow/providers/user_provider.dart';

import '../../providers/entreprises_provider.dart';
import '../../utils/app_colors.dart';
import '../dashboard/dashboard_screen.dart';
import 'custom_sidebar.dart';

// -----------------------------------------------------------------------------
// 6. DRAWER (MENU LATÉRAL)
// -----------------------------------------------------------------------------
class Layout extends ConsumerWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.contains('/order')) return 1;
    if (location.contains('/customer')) return 2;
    if (location.contains('/product')) return 3;
    return 0; // Accueil
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEnterprise = ref.watch(selectedEnterpriseProvider);

    final selectedUser = ref.watch(selectedUserProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      // --- SIDEBAR (DRAWER) ---
      drawer: const CustomSidebar(),

      // --- EN-TÊTE AVEC BORDURE FLOUE ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        // Effet de bordure basse floue via un PreferredSize
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Divider(height: 1, color: Colors.grey.shade100),
          ),
        ),
        title: GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(), // Ouvre la sidebar en cliquant sur le nom
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(selectedEnterprise.name,
                    style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none, color: Colors.grey),
              onPressed: () {
                context.push('/movement-alerts');
              }
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
                onPressed: () { context.push('/profile-setting'); },
                child: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Text(selectedUser.name.substring(0, 1).toUpperCase() ?? "?", style: const TextStyle(color: Colors.white)),
                ),
            )
          )
        ],
      ),

      body: child,

      // --- BOTTOM BAR (4 items maintenant) ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) {
          final paths = ['/dashboard', '/orders', '/customers', '/products'];
          context.go(paths[index]);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey.shade400,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Commandes'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Clients'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Inventaire'),
        ],
      ),
    );
  }
}