import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

Widget buildHeader(String title, String subtitle) {
  return Container(
    padding: const EdgeInsets.all(16),
    color: Colors.white,
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, //"Historique des ventes"
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),

  ),
            const SizedBox(height: 4),
            Text(
              subtitle, //"Gérez vos transactions et états de livraison",
              style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 13),
            ),
          ],
        ),
      ],
    ),
  );
}
