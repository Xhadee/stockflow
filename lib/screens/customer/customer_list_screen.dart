import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stockflow/widgets/build_header.dart';

import '../../widgets/customer_widgets/build_customer_card.dart';

class CustomerListScreen extends ConsumerStatefulWidget {
  const CustomerListScreen({super.key});

  @override
  ConsumerState<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends ConsumerState<CustomerListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: Column(
        children: [
          buildHeader(
              "Listes des clients",
              "Gerez vos clients et consultez leurs commades"),
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: "Rechercher un client...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
              ),
                  onChanged: (value) {
              // Logique de filtrage via Riverpod
            },
            ),
          ),

          // Liste des clients
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: 10, // Remplacer par la longueur de votre liste data
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return buildCustomerCard(
                  context,
                  name: "Papa Samour DIOP",
                  phone: "+221 77 000 00 $index",
                  totalOrders: index + 2,
                  id: "id_$index",
                );
              },
            ),
          ),
        ],
      ),
      // Bouton pour ajouter un client
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2A85FF),
        onPressed: () => context.push('/add-customer'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }


}