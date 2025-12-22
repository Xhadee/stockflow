import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/build_header.dart';
import '../../widgets/order_widgets/build_order_list.dart';
import '../../widgets/order_widgets/build_tab_bar.dart';

class OrderListScreen extends ConsumerStatefulWidget {
  const OrderListScreen({super.key});

  @override
  ConsumerState<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends ConsumerState<OrderListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      // L'AppBar est gérée par le MainLayout, mais on peut ajouter un header ici
      body: Column(
        children: [
          buildHeader(
              "Historique des ventes",
              "Gérez vos transactions et états de livraison"
          ),
          buildTabBar(_tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildOrderList(filter: "Toutes"),
                buildOrderList(filter: "En attente"),
                buildOrderList(filter: "Livrées"),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF2A85FF),
        onPressed: () => context.push('/add-order'),
        icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
        label: const Text("Nouvelle commande", style: TextStyle(color: Colors.white)),
      ),
    );
  }




}