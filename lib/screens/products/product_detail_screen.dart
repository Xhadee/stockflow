import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Détails Produit",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF2A85FF)),
            onPressed: () => context.push('/edit-product/$productId'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProductHeader(),
            const SizedBox(height: 16),
            _buildStockStatusCard(),
            const SizedBox(height: 16),
            _buildPerformanceStats(),
            const SizedBox(height: 16),
            _buildRecentMovements(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(context),
    );
  }

  // 1. Image et Informations de base
  Widget _buildProductHeader() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.image_outlined, size: 60, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const Text("Clavier Mécanique RGB",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text("Catégorie: Gaming",
              style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 8),
          const Text("45.000 FCFA",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2A85FF))),
        ],
      ),
    );
  }

  // 2. État du Stock (Visuel)
  Widget _buildStockStatusCard() {
    int currentStock = 3;
    int minStock = 10;
    bool isLow = currentStock <= minStock;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isLow ? Colors.red.shade100 : Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Niveau de stock", style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isLow ? Colors.red.shade50 : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isLow ? "ALERTE" : "OPTIMAL",
                  style: TextStyle(color: isLow ? Colors.red : Colors.green, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: currentStock / 20, // Exemple: basé sur un max de 20
            backgroundColor: Colors.grey.shade100,
            color: isLow ? Colors.red : Colors.green,
            minHeight: 8,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Actuel: $currentStock unités", style: const TextStyle(fontWeight: FontWeight.w600)),
              Text("Seuil: $minStock unités", style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  // 3. Statistiques de performance
  Widget _buildPerformanceStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _statSmallCard("Vendus (Mois)", "24", Icons.trending_up, Colors.orange),
          const SizedBox(width: 12),
          _statSmallCard("Revenus", "1.08M F", Icons.account_balance_wallet_outlined, Colors.purple),
        ],
      ),
    );
  }

  Widget _statSmallCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  // 4. Derniers Mouvements
  Widget _buildRecentMovements(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("DERNIERS MOUVEMENTS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
              TextButton(onPressed: () => context.push('/movements'), child: const Text("Voir tout")),
            ],
          ),
          _movementItem("Vente CMD-880", "-2", "Hier", Colors.red),
          const Divider(),
          _movementItem("Réapprovisionnement", "+15", "15 Déc.", Colors.green),
        ],
      ),
    );
  }

  Widget _movementItem(String title, String qty, String date, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          Text(qty, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // 5. Actions rapides en bas
  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
      child: SafeArea(
        child: ElevatedButton.icon(
          onPressed: () => context.push('/add-movement'),
          icon: const Icon(Icons.add_business_outlined, color: Colors.white),
          label: const Text("AJOUTER DU STOCK", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2A85FF),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}