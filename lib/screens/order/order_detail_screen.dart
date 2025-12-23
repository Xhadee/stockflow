import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OrderDetailScreen extends ConsumerWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Commande #$orderId",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.print_outlined, color: Color(0xFF2A85FF)),
            onPressed: () { /* Logique impression reçu */ },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildStatusHeader("En attente"),
            const SizedBox(height: 16),
            _buildCustomerInfo(),
            const SizedBox(height: 16),
            _buildOrderItems(),
            const SizedBox(height: 16),
            _buildPaymentSummary(),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: _buildActionButtons(context),
    );
  }

  // 1. En-tête de Statut
  Widget _buildStatusHeader(String status) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status.toUpperCase(),
              style: const TextStyle(color: Color(0xFFE65100), fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(height: 8),
          const Text("Passée le 22 Déc. 2025 à 14:30",
              style: TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }

  // 2. Infos Client
  Widget _buildCustomerInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("CLIENT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 12),
          Row(
            children: [
              const CircleAvatar(backgroundColor: Color(0xFFE3F2FD), child: Icon(Icons.person, color: Color(0xFF2A85FF))),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Papa Samour DIOP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text("+221 77 123 45 67", style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
              const Spacer(),
              IconButton(icon: const Icon(Icons.phone_outlined, color: Colors.green), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  // 3. Liste des produits (Tableau)
  Widget _buildOrderItems() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("PRODUITS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 12),
          _itemRow("Clavier Mécanique RGB", "1", "45.000 F"),
          const Divider(height: 24),
          _itemRow("Souris Logitech G502", "2", "30.000 F"),
        ],
      ),
    );
  }

  Widget _itemRow(String name, String qty, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text("Qté: $qty", style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
        Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  // 4. Résumé Financier
  Widget _buildPaymentSummary() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _summaryLine("Sous-total", "75.000 F"),
          const SizedBox(height: 8),
          _summaryLine("Livraison", "2.000 F"),
          const Divider(height: 24),
          _summaryLine("Total", "77.000 F", isTotal: true),
        ],
      ),
    );
  }

  Widget _summaryLine(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(
          color: isTotal ? Colors.black : Colors.grey,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          fontSize: isTotal ? 16 : 14,
        )),
        Text(value, style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: isTotal ? 18 : 14,
          color: isTotal ? const Color(0xFF2A85FF) : Colors.black,
        )),
      ],
    );
  }

  // 5. Boutons d'action en bas
  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () { /* Annuler la commande */ },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("ANNULER"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () { /* Confirmer la livraison */ },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("LIVRER"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}