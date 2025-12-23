import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Widget pour une ligne de commande
class OrderItem extends StatelessWidget {
  final String id;
  final String client;
  final String date;
  final String status;
  final Color statusColor;
  final Color statusTextColor;

  const OrderItem({
    super.key,
    required this.id,
    required this.client,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.statusTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(id, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text("$client | $date", style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(color: statusTextColor, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}