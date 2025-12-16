import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StockFlow'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: const [
          _HomeCard(title: 'Dashboard', icon: Icons.dashboard),
          _HomeCard(title: 'Produits', icon: Icons.inventory),
          _HomeCard(title: 'Commandes', icon: Icons.receipt_long),
          _HomeCard(title: 'Clients', icon: Icons.people),
          _HomeCard(title: 'Rapports', icon: Icons.bar_chart),
        ],
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _HomeCard({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title – à venir')),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
