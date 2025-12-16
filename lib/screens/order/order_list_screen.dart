import 'package:flutter/material.dart';
import 'order_detail_screen.dart';   // Importation de l'écran de détail
import 'add_edit_order_screen.dart'; // Importation de l'écran d'ajout/modification

class OrderListScreen extends StatefulWidget {
  static const String routeName = '/orders';

  const OrderListScreen({super.key});

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  // Palette de couleurs (maintenue)
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color buttonColor = const Color(0xFFD6955B);

  String _searchQuery = '';

  // Données de simulation des commandes
  List<Map<String, dynamic>> orders = [
    {"id": "1", "number": "ORD-001", "customer": "Alice Dupont", "total": 120.0, "status": "Confirmée", "date": "15/12/2025"},
    {"id": "2", "number": "ORD-002", "customer": "Bob Martin", "total": 80.0, "status": "Brouillon", "date": "14/12/2025"},
    {"id": "3", "number": "ORD-003", "customer": "Charlie Dubois", "total": 200.0, "status": "Expédiée", "date": "13/12/2025"},
    {"id": "4", "number": "ORD-004", "customer": "Diana Leblanc", "total": 55.50, "status": "Annulée", "date": "12/12/2025"},
  ];

  // Fonction pour déterminer la couleur du statut
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmée':
        return Colors.green.shade600;
      case 'Expédiée':
        return buttonColor;
      case 'En préparation':
        return Colors.orange.shade600;
      case 'Annulée':
        return Colors.red.shade600;
      case 'Brouillon':
        return Colors.grey.shade600;
      default:
        return primaryColor;
    }
  }

  List<Map<String, dynamic>> get _filteredOrders {
    if (_searchQuery.isEmpty) return orders;
    return orders.where((order) {
      return order["number"].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          order["customer"].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Gestion des Commandes', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Champ de recherche
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Rechercher par numéro ou client...',
                prefixIcon: Icon(Icons.search, color: secondaryColor),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Liste des commandes
          Expanded(
            child: _filteredOrders.isEmpty
                ? Center(child: Text('Aucune commande trouvée', style: TextStyle(color: secondaryColor)))
                : ListView.builder(
              itemCount: _filteredOrders.length,
              itemBuilder: (context, index) {
                final order = _filteredOrders[index];
                final statusColor = _getStatusColor(order["status"]);

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Icon(Icons.receipt_long, color: primaryColor, size: 30),
                    title: Text(
                      order["number"],
                      style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                    subtitle: Text('Client: ${order["customer"]} | ${order["date"]}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${order["total"].toStringAsFixed(2)} €',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: buttonColor),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            order["status"],
                            style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Naviguer vers l'écran de détail, en passant les données de la commande
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => OrderDetailScreen(order: order)),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Bouton flottant pour ajouter une nouvelle commande
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.add, size: 30),
        onPressed: () {
          // Naviguer vers l'écran d'ajout de commande (sans passer de données)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditOrderScreen()),
          );
        },
      ),
    );
  }
}