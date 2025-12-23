import 'package:flutter/material.dart';

import 'contact_tile.dart';


// 3. Informations de contact
Widget buildContactInfo() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        contactTile(Icons.phone_outlined, "Téléphone", "+221 77 123 45 67"),
        const Divider(height: 24),
        contactTile(Icons.email_outlined, "Email", "papsamourdiop@example.com"),
        const Divider(height: 24),
        contactTile(Icons.location_on_outlined, "Adresse", "Sacré-Cœur 3, Dakar"),
      ],
    ),
  );
}
