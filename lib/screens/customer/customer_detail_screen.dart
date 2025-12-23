import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/customer_widgets/build_contact_info.dart';
import '../../widgets/customer_widgets/build_order_history.dart';
import '../../widgets/customer_widgets/build_profile_header.dart';
import '../../widgets/customer_widgets/build_stat_row.dart';

class CustomerDetailScreen extends ConsumerWidget {
  final String customerId;

  const CustomerDetailScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ici, vous récupéreriez les données du client via son ID
    // final customer = ref.watch(customerProvider(customerId));

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("Détails Client", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF2A85FF)),
            onPressed: () => context.push('/edit-customer/$customerId'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildProfileHeader(),
            const SizedBox(height: 16),
            buildStatsRow(),
            const SizedBox(height: 16),
            buildContactInfo(),
            const SizedBox(height: 16),
            buildOrderHistory(),
          ],
        ),
      ),
    );
  }






}