import 'package:flutter/material.dart';
import 'add_edit_screen_product.dart';
import '../../models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product-detail';
  final Product product;

  const ProductDetailScreen({required this.product, super.key});

  // Palette de couleurs (maintenue)
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color buttonColor = const Color(0xFFD6955B);

  // Widget pour afficher une ligne d'information stylisée
  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: secondaryColor, size: 24),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: secondaryColor.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: 250, // Limite la largeur pour que le texte long ne déborde pas
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLowStock = product.quantity < 10;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          // Bouton d'édition
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddEditProductScreen(product: product)),
              );
            },
          ),
          // Bouton de suppression simulé
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
            onPressed: () {
              // Action de suppression
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Suppression de ${product.name} (simulée).')),
              );
              Navigator.pop(context); // Retour à la liste après suppression
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Indicateur de stock en haut
            Card(
              color: isLowStock ? Colors.red.shade50 : Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Stock Actuel:',
                      style: TextStyle(fontSize: 18, color: secondaryColor, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        if (isLowStock)
                          Icon(Icons.warning_rounded, color: Colors.redAccent, size: 28),
                        const SizedBox(width: 8),
                        Text(
                          '${product.quantity} unités',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: isLowStock ? Colors.redAccent : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Détails du produit
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: primaryColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informations Clés',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                  const Divider(height: 25, color: Colors.black12),

                  _buildInfoRow('Nom du produit', product.name, Icons.label_important),
                  _buildInfoRow('Code SKU', product.sku, Icons.qr_code_2),
                  _buildInfoRow('Prix unitaire', '${product.price.toStringAsFixed(2)} €', Icons.monetization_on),

                  // Description
                  const SizedBox(height: 15),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: secondaryColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product.description ?? 'Aucune description fournie.',
                    style: TextStyle(fontSize: 16, color: primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}