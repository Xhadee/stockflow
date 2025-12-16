import 'package:flutter/material.dart';
// Note: Nous utilisons Map<String, dynamic> pour la simplicité, mais un modèle Order dédié serait mieux.
// import 'order_model.dart';
import 'add_edit_order_screen.dart'; // Étape suivante

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  // Données simulées pour les lignes de commande (à intégrer dans le modèle final)
  final List<Map<String, dynamic>> items = [
    {"name": "T-shirt Coton Bleu", "quantity": 2, "price": 15.99},
    {"name": "Jean Slim Noir", "quantity": 1, "price": 45.00},
  ];

  OrderDetailScreen({required this.order, super.key});

  // Palette de couleurs (maintenue)
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color buttonColor = const Color(0xFFD6955B);

  // Déterminer la couleur du statut
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmée':
        return Colors.green.shade600;
      case 'Expédiée':
        return buttonColor;
      case 'Brouillon':
        return Colors.grey.shade600;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(order["status"]);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Text('Détail Commande #${order["number"]}', style: const TextStyle(fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddEditOrderScreen(order: order)),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Suppression de la commande ${order["number"]} (simulée).')),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Carte Statut et Totaux ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Statut actuel:', style: TextStyle(color: secondaryColor.withOpacity(0.7), fontSize: 14)),
                    const SizedBox(height: 5),
                    Text(
                      order["status"],
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: statusColor),
                    ),
                    const Divider(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total TTC:', style: TextStyle(color: primaryColor, fontSize: 18)),
                        Text(
                          '${order["total"].toStringAsFixed(2)} €',
                          style: TextStyle(color: primaryColor, fontSize: 22, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- Informations Client ---
            Text('Informations Client', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(Icons.person, 'Client', order["customer"]),
                  _buildInfoRow(Icons.phone, 'Téléphone', 'N/A'),
                  _buildInfoRow(Icons.home, 'Adresse', '123 Rue de Flutter, 75000 Paris'),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- Articles de la Commande ---
            Text('Articles Commandés', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    leading: CircleAvatar(
                      backgroundColor: secondaryColor.withOpacity(0.1),
                      child: Text('${item["quantity"]}x', style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor)),
                    ),
                    title: Text(item["name"], style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
                    trailing: Text('${(item["price"] * item["quantity"]).toStringAsFixed(2)} €'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: buttonColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 12, color: secondaryColor.withOpacity(0.6))),
                Text(value, style: TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}