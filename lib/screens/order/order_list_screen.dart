import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';
import '../inventory/movement_list_screen.dart';
// import '../setting/settings_screen.dart';
import 'add_edit_order_screen.dart';
import 'order_detail_screen.dart';
import '../../widgets/order_card.dart';

class OrderListScreen extends StatefulWidget {
  static const String routeName = '/order-list';

  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  // Palette StockFlow
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  int _currentIndex = 1; // Commandes par défaut

  // Données mockées commandes
  final List<Map<String, dynamic>> orders = [
    {
      'client': 'Client A',
      'status': 'Brouillon',
      'products': [
        {'name': 'Produit A', 'quantity': 2},
        {'name': 'Produit B', 'quantity': 1},
      ],
      'total': 30,
    },
    {
      'client': 'Client B',
      'status': 'Confirmée',
      'products': [
        {'name': 'Produit C', 'quantity': 5},
      ],
      'total': 50,
    },
    {
      'client': 'Client C',
      'status': 'Livrée',
      'products': [
        {'name': 'Produit A', 'quantity': 1},
        {'name': 'Produit B', 'quantity': 2},
      ],
      'total': 40,
    },
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DashboardScreen()),
        );
        break;
      case 1:
      // Commandes déjà ici
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MovementListScreen()),
        );
        break;
      // case 3:
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (_) => const SettingsScreen()),
      //   );
      //   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Commandes'),
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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.separated(
                itemCount: orders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrderCard(
                    order: order,
                    primaryColor: primaryColor,
                    secondaryColor: secondaryColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrderDetailScreen(order: order),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditOrderScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
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
            label: 'Commandes',
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

