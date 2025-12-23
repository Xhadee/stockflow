import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EnterpriseListScreen extends ConsumerWidget {
  const EnterpriseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Dans un cas réel, vous écouteriez votre provider d'entreprises
    // final enterprises = ref.watch(enterprisesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          "Mes Entreprises",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          _buildInfoBanner(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 3, // Exemple : 3 entreprises
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                // Simulation de données
                final names = ["Seydou's Shop", "Malick Electronics", "Dakar Fashion"];
                final roles = ["Propriétaire", "Administrateur", "Gestionnaire"];

                return _buildEnterpriseCard(
                  context,
                  name: names[index],
                  role: roles[index],
                  logo: names[index].substring(0, 1),
                  isSelected: index == 0, // La première est active par défaut
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF2A85FF),
        onPressed: () => context.push('/add-enterprise'),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Ajouter une entreprise", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFE3F2FD).withOpacity(0.5),
      child: const Text(
        "Sélectionnez une entreprise pour gérer son inventaire et ses ventes.",
        style: TextStyle(color: Color(0xFF1976D2), fontSize: 13),
      ),
    );
  }

  Widget _buildEnterpriseCard(
      BuildContext context, {
        required String name,
        required String role,
        required String logo,
        required bool isSelected,
      }) {
    return InkWell(
      onTap: () {
        // 1. Logique pour changer l'entreprise active via Riverpod
        // 2. Rediriger vers le dashboard
        context.go('/');
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF2A85FF) : Colors.grey.shade100,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: isSelected ? const Color(0xFF2A85FF) : Colors.grey.shade100,
              child: Text(
                logo,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    role,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF2A85FF), size: 24)
            else
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.grey, size: 20),
                onPressed: () => context.push('/edit-enterprise/123'),
              ),
          ],
        ),
      ),
    );
  }
}