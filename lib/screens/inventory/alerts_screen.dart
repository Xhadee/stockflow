import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  static const String routeName = '/alerts';

  AlertsScreen({super.key});

  // Palette StockFlow
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  // Données mockées : produits avec stock faible
  final List<Map<String, dynamic>> lowStockProducts = const [
    {'name': 'Produit A', 'stock': 3, 'threshold': 5},
    {'name': 'Produit B', 'stock': 1, 'threshold': 5},
    {'name': 'Produit C', 'stock': 2, 'threshold': 5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Alertes Stock Faible'),
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 🎨 Décoration arrière-plan
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Description
                  Text(
                    'Produits dont le stock est inférieur au seuil défini',
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryColor.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Liste
                  Expanded(
                    child: ListView.separated(
                      itemCount: lowStockProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final product = lowStockProducts[index];
                        return _LowStockCard(
                          name: product['name'],
                          stock: product['stock'],
                          threshold: product['threshold'],
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

class _LowStockCard extends StatelessWidget {
  final String name;
  final int stock;
  final int threshold;
  final Color primaryColor;
  final Color secondaryColor;

  const _LowStockCard({
    required this.name,
    required this.stock,
    required this.threshold,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icone produit
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.inventory_2, color: secondaryColor),
          ),
          const SizedBox(width: 16),

          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Stock actuel: $stock (Seuil: $threshold)',
                  style: TextStyle(
                    color: secondaryColor.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Badge alerte
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'FAIBLE',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
