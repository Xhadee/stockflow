import 'package:flutter/material.dart';
// 🛑 CORRECTION ICI 🛑 : Ajout du point-virgule et utilisation du nom correct si vous avez suivi la suggestion
import 'add_edit_screen_product.dart';
import 'product_detail_screen.dart';
import '../../models/product_model.dart';

class ProductListScreen extends StatefulWidget {
  static const String routeName = '/products';

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // Palette de couleurs (maintenue)
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  // Données de simulation (à remplacer par Firebase/API)
  List<Product> products = [
    Product(id: '1', name: 'T-shirt Coton Bleu', price: 15.99, quantity: 50, sku: 'TSCB-001'),
    Product(id: '2', name: 'Jean Slim Noir', price: 45.00, quantity: 15, sku: 'JSN-002'),
    Product(id: '3', name: 'Casquette Logo', price: 8.50, quantity: 5, sku: 'CL-003'), // Faible stock
    Product(id: '4', name: 'Chaussures Cuir', price: 89.99, quantity: 100, sku: 'CC-004'),
  ];

  String _searchQuery = '';

  // Fonction pour construire une tuile de produit
  Widget _buildProductTile(BuildContext context, Product product) {
    // Vérification du stock bas
    bool isLowStock = product.quantity < 10;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: isLowStock ? BorderSide(color: Colors.redAccent, width: 2) : BorderSide.none,
      ),
      child: ListTile(
        onTap: () {
          // Naviguer vers l'écran de détail
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
          );
        },
        // Indicateur de stock (rond ou icône)
        leading: CircleAvatar(
          backgroundColor: isLowStock ? Colors.redAccent.withOpacity(0.9) : secondaryColor,
          child: isLowStock
              ? Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20)
              : Text(
            product.quantity.toString(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        title: Text(
          product.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
        ),
        subtitle: Text(
          'SKU: ${product.sku} | Prix: ${product.price.toStringAsFixed(2)} €',
          style: TextStyle(color: secondaryColor.withOpacity(0.7)),
        ),
        trailing: isLowStock
            ? Text('Stock bas !', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold))
            : Icon(Icons.chevron_right, color: buttonColor),
      ),
    );
  }

  // Fonction de filtre
  List<Product> get _filteredProducts {
    if (_searchQuery.isEmpty) {
      return products;
    }
    return products.where((product) {
      return product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.sku.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text('Gestion des Produits', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0, // Enlève l'ombre de l'AppBar
      ),
      body: Column(
        children: [
          // Champ de recherche stylisé
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Rechercher par nom ou SKU...',
                  hintStyle: TextStyle(color: secondaryColor.withOpacity(0.5)),
                  prefixIcon: Icon(Icons.search, color: secondaryColor),
                  border: InputBorder.none, // Enlever la bordure interne
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
              ),
            ),
          ),

          // Liste des produits
          Expanded(
            child: _filteredProducts.isEmpty
                ? Center(
              child: Text(
                _searchQuery.isEmpty ? 'Aucun produit en stock.' : 'Aucun résultat trouvé.',
                style: TextStyle(color: secondaryColor, fontSize: 18),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                return _buildProductTile(context, _filteredProducts[index]);
              },
            ),
          ),
        ],
      ),

      // Bouton flottant pour ajouter un nouveau produit
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers l'écran d'ajout (mode ajout)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditProductScreen()),
          );
        },
        backgroundColor: buttonColor,
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}