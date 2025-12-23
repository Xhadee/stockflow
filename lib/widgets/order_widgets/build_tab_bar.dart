import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget buildTabBar(
    TabController tabController
    ) {
  return Container(
    color: Colors.white,
    child: TabBar(
      controller: tabController,
      labelColor: const Color(0xFF2A85FF),
      unselectedLabelColor: Colors.grey,
      indicatorColor: const Color(0xFF2A85FF),
      indicatorWeight: 3,
      tabs: const [
        Tab(text: "Toutes"),
        Tab(text: "En attente"),
        Tab(text: "Livrées"),
      ],
    ),
  );
}

