import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final Color primaryColor;
  final Color secondaryColor;

  const CustomerCard({
    required this.name,
    required this.phone,
    required this.email,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        // TODO: Navigation vers détail / édition client
      },
      child: Container(
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
            // Avatar
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: secondaryColor,
              ),
            ),
            const SizedBox(width: 16),

            // Infos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    phone,
                    style: TextStyle(
                      color: secondaryColor.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      color: secondaryColor.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // Action
            Icon(
              Icons.chevron_right,
              color: secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
