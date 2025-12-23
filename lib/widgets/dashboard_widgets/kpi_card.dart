import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Widget pour les cartes colorées (Commandes, Revenus, Stock)
class KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  final Color iconColor;

  const KpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 12),
          Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        ],
      ),
    );
  }
}