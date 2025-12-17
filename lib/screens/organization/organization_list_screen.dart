import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';
import '../inventory/movement_list_screen.dart';
// import '../setting/settings_screen.dart';
import 'add_edit_organization_screen.dart';
import '../../widgets/organization_card.dart';

class OrganizationListScreen extends StatefulWidget {
  static const String routeName = '/organization-list';

  const OrganizationListScreen({super.key});

  @override
  State<OrganizationListScreen> createState() => _OrganizationListScreenState();
}

class _OrganizationListScreenState extends State<OrganizationListScreen> {
  // Palette StockFlow
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  int _currentIndex = 0;

  // Données mockées
  List<Map<String, dynamic>> organizations = [
    {'name': 'Entreprise A', 'currency': 'EUR'},
    {'name': 'Entreprise B', 'currency': 'USD'},
    {'name': 'Entreprise C', 'currency': 'CFA'},
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
      // Dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DashboardScreen()),
        );
        break;
      case 1:
      // Commandes → TODO: remplacer par order_list_screen
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MovementListScreen()),
        );
        break;
    //   case 3:
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (_) => const SettingsScreen()),
    //     );
    //     break;
    }
  }

  void _addOrEditOrganization({Map<String, dynamic>? organization}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) =>
              AddEditOrganizationScreen(organization: organization)),
    );

    if (result != null) {
      setState(() {
        if (organization != null) {
          // Modifier
          final index = organizations.indexOf(organization);
          organizations[index] = result;
        } else {
          // Ajouter
          organizations.add(result);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Organisations'),
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
                itemCount: organizations.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final org = organizations[index];
                  return OrganizationCard(
                    organization: org,
                    primaryColor: primaryColor,
                    secondaryColor: secondaryColor,
                    onTap: () => _addOrEditOrganization(organization: org),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () => _addOrEditOrganization(),
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


