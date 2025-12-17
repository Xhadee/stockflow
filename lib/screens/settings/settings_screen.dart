import 'package:flutter/material.dart';
import 'package:stockflow/screens/products/product_list_screen.dart';
import 'package:stockflow/widgets/setting_tile.dart';
import '../dashboard/dashboard_screen.dart';
import '../inventory/movement_list_screen.dart';
import 'user_management_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Palette StockFlow
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  int _currentIndex = 3; // Paramètres

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProductListScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MovementListScreen()),
        );
        break;
      case 3:
      // Déjà sur paramètres
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Décoration
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.35),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                settingsTile(
                  icon: Icons.person,
                  title: 'Profil',
                  subtitle: 'Modifier vos informations personnelles',
                  onTap: () {
                    // TODO: Page Profil
                  },
                ),
                settingsTile(
                  icon: Icons.group,
                  title: 'Gestion des utilisateurs',
                  subtitle: 'Ajouter, modifier ou supprimer des utilisateurs',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UserManagementScreen(),
                      ),
                    );
                  },
                ),
                settingsTile(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  subtitle: 'Gérer les notifications',
                  onTap: () {
                    // TODO: Page Notifications
                  },
                ),
                settingsTile(
                  icon: Icons.info,
                  title: 'À propos',
                  subtitle: 'Version de l’application et informations',
                  onTap: () {
                    // TODO: Page À propos
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Produits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Inventaire',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }

}