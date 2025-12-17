// import 'package:flutter/material.dart';
//
// class BottomNavigationBar extends StatelessWidget {
//   final String title;
//
//   const BottomNavigationBar({required this.title});
//
//   void _onBottomNavTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//
//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const DashboardScreen()),
//         );
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const ProductListScreen()),
//         );
//         break;
//       case 2:
//       // Déjà sur fournisseur/inventaire (pour l'instant)
//         break;
//       case 3:
//       // Paramètres
//       // TODO: Ajouter navigation vers SettingsScreen
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: Color(0xFF18534F),
//       ),
//     );
//   }
// }