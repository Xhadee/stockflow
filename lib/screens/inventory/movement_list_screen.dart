import 'package:flutter/material.dart';
import 'add_movement_screen.dart';
import '../../widgets/movement_card.dart';

class MovementListScreen extends StatelessWidget {
  static const String routeName = '/movement-list';

  const MovementListScreen({super.key});

  // Palette StockFlow
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  // Données mockées mouvements
  final List<Map<String, dynamic>> movements = const [
    {
      'product': 'Produit A',
      'type': 'Entrée',
      'quantity': 10,
      'comment': 'Réapprovisionnement'
    },
    {
      'product': 'Produit B',
      'type': 'Sortie',
      'quantity': 3,
      'comment': 'Commande client #12'
    },
    {
      'product': 'Produit C',
      'type': 'Entrée',
      'quantity': 5,
      'comment': 'Retour fournisseur'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Mouvements de stock'),
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Décoration
          Positioned(
            top: -100,
            left: -100,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: movements.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final movement = movements[index];
                        return MovementCard(
                          product: movement['product'],
                          type: movement['type'],
                          quantity: movement['quantity'],
                          comment: movement['comment'],
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddMovementScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}