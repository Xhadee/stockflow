import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';

// Widget pour une ligne d'alerte de stock
class StockAlertItem extends StatelessWidget {
  final String name;
  const StockAlertItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.kpiRed, // Fond rosâtre
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text("Stock Actuel: 3 | il y'a 2 heures", style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey)),
            ],
          ),
          const Icon(Icons.chevron_right, color: Colors.black54),
        ],
      ),
    );
  }
}