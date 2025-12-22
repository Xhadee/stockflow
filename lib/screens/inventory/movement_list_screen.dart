import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart'; // Pour formater les dates

class MovementListScreen extends ConsumerWidget {
  const MovementListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          "Historique des mouvements",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // Optionnel : Ouvrir un filtre par date ou par type (Entrée/Sortie)
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Résumé rapide des 30 derniers jours (Optionnel)
          _buildQuickSummary(),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 15, // À remplacer par vos données dynamiques
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                // Simulation de données alternées Entrée/Sortie
                final isStockIn = index % 2 == 0;
                return _buildMovementTile(
                  productName: isStockIn ? "Clavier Mécanique RGB" : "Souris Logitech G502",
                  quantity: isStockIn ? 20 : 5,
                  date: DateTime.now().subtract(Duration(days: index)),
                  type: isStockIn ? "Entrée" : "Sortie",
                  note: isStockIn ? "Réapprovisionnement fournisseur" : "Vente client #CMD-123",
                );
              },
            ),
          ),
        ],
      ),
      // Bouton pour ajouter un mouvement directement depuis l'historique
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF2A85FF),
        onPressed: () => context.push('/add-movement'),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Nouveau mouvement", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildQuickSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _summaryItem("Entrées", "+124", Colors.green),
          Container(width: 1, height: 30, color: Colors.grey.shade200),
          _summaryItem("Sorties", "-86", Colors.red),
        ],
      ),
    );
  }

  Widget _summaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildMovementTile({
    required String productName,
    required int quantity,
    required DateTime date,
    required String type,
    required String note,
  }) {
    final bool isEntry = type == "Entrée";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          // Icône d'état
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isEntry ? Colors.green.shade50 : Colors.red.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isEntry ? Icons.south_west : Icons.north_east,
              color: isEntry ? Colors.green : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  note,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('dd MMM yyyy à HH:mm').format(date),
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
                ),
              ],
            ),
          ),
          // Quantité
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isEntry ? '+' : '-'}$quantity",
                style: TextStyle(
                  color: isEntry ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "Unités",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}