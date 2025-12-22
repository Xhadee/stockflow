import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
//import 'url_launcher/url_launcher.dart'; // Optionnel pour appeler directement

class SupplierListScreen extends ConsumerWidget {
  const SupplierListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          "Fournisseurs",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // Simulation
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final suppliers = [
            "Samsung Electronics",
            "Sodefitex",
            "Grossiste Informatique",
            "Dakar Logistique",
            "Bureau Vallée"
          ];
          final categories = ["Électronique", "Textile", "Hardware", "Transport", "Papeterie"];

          return _buildSupplierCard(
            context,
            name: suppliers[index],
            category: categories[index],
            contact: "Jean Faye",
            phone: "+221 33 800 10 20",
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF2A85FF),
        onPressed: () => context.push('/add-supplier'),
        icon: const Icon(Icons.add_business, color: Colors.white),
        label: const Text("Ajouter", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildSupplierCard(
      BuildContext context, {
        required String name,
        required String category,
        required String contact,
        required String phone,
      }) {
    return InkWell(
      onTap: () => context.push('/edit-supplier/123'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFE3F2FD),
                  child: Text(name.substring(0, 1),
                      style: const TextStyle(color: Color(0xFF2A85FF), fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(category, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(contact, style: const TextStyle(fontSize: 13)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.phone_outlined, size: 20, color: Colors.green),
                      onPressed: () {
                        // Logique pour lancer l'appel
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.email_outlined, size: 20, color: Color(0xFF2A85FF)),
                      onPressed: () {
                        // Logique pour envoyer un email
                      },
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}