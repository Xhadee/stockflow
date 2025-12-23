import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddEditOrderScreen extends ConsumerStatefulWidget {
  final String? orderId;
  const AddEditOrderScreen({super.key, this.orderId});

  @override
  ConsumerState<AddEditOrderScreen> createState() => _AddEditOrderScreenState();
}

class _AddEditOrderScreenState extends ConsumerState<AddEditOrderScreen> {
  // Simulation d'une liste de produits sélectionnés
  final List<Map<String, dynamic>> _selectedItems = [
    {"name": "Clavier Mécanique", "price": 45000, "qty": 1},
  ];

  double get _totalAmount => _selectedItems.fold(0, (sum, item) => sum + (item['price'] * item['qty']));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: Text(widget.orderId == null ? "Nouvelle Commande" : "Modifier Commande",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
        actions: [
          TextButton(
            onPressed: () => _submitOrder(),
            child: const Text("VALIDER", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2A85FF))),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Client"),
                  const SizedBox(height: 8),
                  _buildClientSelector(),
                  const SizedBox(height: 24),
                  _buildSectionTitle("Produits"),
                  const SizedBox(height: 8),
                  ..._selectedItems.map((item) => _buildProductItem(item)).toList(),
                  const SizedBox(height: 12),
                  _buildAddProductButton(),
                ],
              ),
            ),
          ),
          _buildSummarySection(),
        ],
      ),
    );
  }

  // Sélecteur de client
  Widget _buildClientSelector() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 18, backgroundColor: Color(0xFFE3F2FD), child: Icon(Icons.person, size: 18)),
          const SizedBox(width: 12),
          const Expanded(
            child: Text("Choisir un client", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline, color: Color(0xFF2A85FF))),
        ],
      ),
    );
  }

  // Élément de produit dans la liste
  Widget _buildProductItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("${item['price']} FCFA", style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),
          Row(
            children: [
              _qtyBtn(Icons.remove, () {}),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text("${item['qty']}", style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              _qtyBtn(Icons.add, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(6)),
        child: Icon(icon, size: 18),
      ),
    );
  }

  Widget _buildAddProductButton() {
    return InkWell(
      onTap: () {}, // Ouvrir une boîte de dialogue ou une page de sélection de produits
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF2A85FF), style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Color(0xFF2A85FF), size: 20),
            SizedBox(width: 8),
            Text("Ajouter un produit", style: TextStyle(color: Color(0xFF2A85FF), fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Résumé en bas de l'écran (Fixe)
  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total à payer", style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text("${_totalAmount.toInt()} FCFA",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
            ElevatedButton(
              onPressed: _submitOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A85FF),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Valider", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
  }

  void _submitOrder() {
    context.pop();
  }
}