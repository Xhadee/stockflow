import 'package:flutter/material.dart';
import 'add_edit_product_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product-detail';

  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  // Palette StockFlow
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Détails produit'),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom
                  Text(
                    product['name'] ?? 'Nom produit',
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  // Catégorie
                  _detailRow('Catégorie', product['category'] ?? '-'),

                  // Stock actuel
                  _detailRow('Stock actuel', '${product['stock'] ?? 0}'),

                  // Seuil d’alerte
                  _detailRow('Seuil alerte', '${product['alertThreshold'] ?? 0}'),

                  // Prix HT
                  _detailRow('Prix HT', '${product['priceHT'] ?? 0}'),

                  // Statut
                  _detailRow('Statut', (product['active'] ?? true) ? 'Actif' : 'Archivé'),

                  const Spacer(),

                  // Bouton Modifier
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddEditProductScreen(
                              title: 'Modifier produit',
                              entity: product,
                              onSave: (data) {
                                print('Produit modifié: $data');
                              },
                            ),
                          ),
                        );
                        if (result != null) {
                          // TODO: Mettre à jour le produit
                        }
                      },
                      child: const Text(
                        'Modifier',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
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

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
