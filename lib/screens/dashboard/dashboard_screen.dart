import 'package:flutter/material.dart';
import 'package:stockflow/screens/products/product_list_screen.dart';
import 'package:stockflow/screens/settings/user_management_screen.dart';
import '../inventory/movement_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  int _selectedIndex = 0;

  // Mock données statistiques
  final int totalOrdersToday = 12;
  final double totalSalesToday = 1540.50;
  final int lowStockProducts = 5;

  final List<Map<String, String>> recentOrders = [
    {'id': 'CMD-001', 'client': 'Seydou Diallo', 'status': 'Confirmée'},
    {'id': 'CMD-002', 'client': 'Awa Ndiaye', 'status': 'Brouillon'},
    {'id': 'CMD-003', 'client': 'Mamadou Ba', 'status': 'Livrée'},
  ];

  // // Pages BottomNavigationBar
  // List<Widget> get _pages => [
  //   _buildDashboardBody(),
  //   const ProductListScreen(),
  //   const MovementListScreen(),
  //   const UserManagementScreen(),
  // ];
  //
  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _buildDashboardBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
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

  Widget _buildDashboardBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tableau de bord',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // --- KPIs avec Wrap responsive ---
            Wrap(
              spacing: 8,
              runSpacing: 12,
              children: [
                _buildKpiCard(
                  title: 'Commandes du jour',
                  value: totalOrdersToday.toString(),
                  color: Colors.orangeAccent,
                  icon: Icons.shopping_cart,
                  onTap: () {}, // pour le KPI Commandes, on peut ajouter la navigation plus tard
                ),
                _buildKpiCard(
                  title: 'Ventes du jour',
                  value: '${totalSalesToday.toStringAsFixed(2)} \$',
                  color: Colors.greenAccent,
                  icon: Icons.attach_money,
                  onTap: () {},
                ),
                _buildKpiCard(
                  title: 'Stock faible',
                  value: lowStockProducts.toString(),
                  color: Colors.redAccent,
                  icon: Icons.warning_amber_rounded,
                  onTap: () {
                    // Naviguer vers la page des produits en faible stock
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MovementListScreen(), // ou LowStockProductsScreen()
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // --- Alertes stock faible ---
            if (lowStockProducts > 0)
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => const MovementListScreen(),
                  //   ),
                  // );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning, color: Colors.red),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Attention ! $lowStockProducts produit(s) en stock faible.',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red)
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 20),
            const Text(
              'Commandes récentes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(), // pour éviter conflit Scroll
              shrinkWrap: true,
              itemCount: recentOrders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final order = recentOrders[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order['id']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order['client']!,
                            style: TextStyle(
                              color: secondaryColor.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order['status']!).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          order['status']!,
                          style: TextStyle(
                            color: _getStatusColor(order['status']!),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(
      {required String title,
        required String value,
        required Color color,
        required IconData icon,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 140, // largeur fixe pour Wrap
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Icon(icon, size: 30, color: color),
              const SizedBox(height: 12),
              Text(
                value,
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: color),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: color.withOpacity(0.8)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Brouillon':
        return Colors.orange;
      case 'Confirmée':
        return Colors.blue;
      case 'Livrée':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
