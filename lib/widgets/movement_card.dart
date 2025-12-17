import 'package:flutter/material.dart';

class MovementCard extends StatelessWidget {
  final String product;
  final String type;
  final int quantity;
  final String comment;
  final Color primaryColor;
  final Color secondaryColor;

  const MovementCard({
    required this.product,
    required this.type,
    required this.quantity,
    required this.comment,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    Color typeColor = type == 'Entrée' ? Colors.green : Colors.redAccent;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icone type mouvement
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              type == 'Entrée' ? Icons.arrow_downward : Icons.arrow_upward,
              color: typeColor,
            ),
          ),
          const SizedBox(width: 16),

          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$type : $quantity unités',
                  style: TextStyle(
                    color: secondaryColor.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                if (comment.isNotEmpty)
                  Text(
                    'Commentaire: $comment',
                    style: TextStyle(
                      color: secondaryColor.withOpacity(0.7),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}