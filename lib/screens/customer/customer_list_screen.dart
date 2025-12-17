import 'package:flutter/material.dart';

import '../../widgets/customer_card.dart';

class CustomerListScreen extends StatelessWidget {
  static const String routeName = '/customers';

  // Palette (identique à toute l’app)
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  const CustomerListScreen({super.key});

  // 🔹 Données mockées (remplacées plus tard par Firestore)
  final List<Map<String, String>> customers = const [
    {
      'name': 'Boutique Ndiaye',
      'phone': '+221 77 123 45 67',
      'email': 'ndiaye@boutique.sn',
    },
    {
      'name': 'Marché Central',
      'phone': '+221 76 456 78 90',
      'email': 'contact@marche.sn',
    },
    {
      'name': 'Super Shop Dakar',
      'phone': '+221 78 987 65 43',
      'email': 'info@supershop.sn',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // ➕ Bouton flottant
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () {
          // TODO: Navigation vers AddEditCustomerScreen
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Stack(
        children: [
          // 🎨 Décoration arrière-plan
          Positioned(
            bottom: -120,
            left: -120,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.35),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🧑‍🤝‍🧑 En-tête
                  Text(
                    'Clients',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Gérez vos clients et leurs informations',
                    style: TextStyle(
                      fontSize: 15,
                      color: secondaryColor.withOpacity(0.7),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 📋 Liste des clients
                  Expanded(
                    child: ListView.separated(
                      itemCount: customers.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final customer = customers[index];
                        return CustomerCard(
                          name: customer['name']!,
                          phone: customer['phone']!,
                          email: customer['email']!,
                          primaryColor: primaryColor,
                          secondaryColor: secondaryColor,

                        );
                      },

                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
