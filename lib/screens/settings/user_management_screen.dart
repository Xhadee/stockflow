import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserManagementScreen extends ConsumerWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          "Gestion d'Équipe",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTeamSummary(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 4, // Simulation de l'équipe
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final names = ["Moussa Diop", "Fatou Sarr", "Amadou Fall", "Binta Wade"];
                final roles = ["Administrateur", "Vendeur", "Gérant", "Vendeur"];
                final status = [true, true, true, false]; // true = actif

                return _buildUserCard(
                  context,
                  name: names[index],
                  role: roles[index],
                  isActive: status[index],
                  initials: names[index].substring(0, 1),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF2A85FF),
        onPressed: () => context.push('/add-user'),
        icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
        label: const Text("Ajouter un membre", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildTeamSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _summaryStat("4", "Membres"),
          _summaryStat("3", "Actifs"),
          _summaryStat("1", "Inactif"),
        ],
      ),
    );
  }

  Widget _summaryStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
      ],
    );
  }

  Widget _buildUserCard(
      BuildContext context, {
        required String name,
        required String role,
        required bool isActive,
        required String initials,
      }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: isActive ? const Color(0xFFE3F2FD) : Colors.grey.shade100,
            child: Text(
              initials,
              style: TextStyle(
                color: isActive ? const Color(0xFF2A85FF) : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 2),
                Text(role, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive ? Colors.green.shade50 : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isActive ? "ACTIF" : "SUSPENDU",
                  style: TextStyle(
                    color: isActive ? Colors.green : Colors.red,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.grey, size: 20),
                onPressed: () {
                  // Menu d'options : Modifier, Suspendre, Supprimer
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}