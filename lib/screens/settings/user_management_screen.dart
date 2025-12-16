import 'package:flutter/material.dart';
import 'add_edit_user_screen.dart'; // Étape suivante

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  // Palette de couleurs (maintenue)
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color buttonColor = const Color(0xFFD6955B);

  // Données de simulation des utilisateurs
  List<Map<String, dynamic>> users = [
    {"id": "u1", "name": "Admin Principal", "email": "admin@stockflow.com", "role": "Administrateur", "status": "Actif"},
    {"id": "u2", "name": "Demba DIOP", "email": "jean.d@stockflow.com", "role": "Gestionnaire Stock", "status": "Actif"},
    {"id": "u3", "name": "Khady NDIAYE", "email": "marie.l@stockflow.com", "role": "Vendeur", "status": "Inactif"},
  ];

  Color _getRoleColor(String role) {
    switch (role) {
      case 'Administrateur':
        return Colors.red.shade400;
      case 'Gestionnaire Stock':
        return Colors.blue.shade600;
      case 'Vendeur':
        return buttonColor;
      default:
        return secondaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Gestion des Utilisateurs', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final roleColor = _getRoleColor(user["role"]);

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              // Optionnel: Ajouter une bordure pour les utilisateurs inactifs
              side: user["status"] == "Inactif" ? BorderSide(color: Colors.grey.shade300, width: 1) : BorderSide.none,
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: roleColor.withOpacity(0.1),
                child: Icon(Icons.person, color: roleColor),
              ),
              title: Text(
                user["name"],
                style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user["email"], style: TextStyle(color: secondaryColor.withOpacity(0.7))),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: roleColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          user["role"],
                          style: TextStyle(color: roleColor, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Indicateur de statut
                      Icon(
                        user["status"] == "Actif" ? Icons.circle : Icons.circle,
                        color: user["status"] == "Actif" ? Colors.green : Colors.grey,
                        size: 10,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        user["status"]!,
                        style: TextStyle(fontSize: 12, color: user["status"] == "Actif" ? Colors.green : Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Icon(Icons.chevron_right, color: buttonColor),
              onTap: () {
                // Naviguer vers l'écran d'édition de l'utilisateur
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddEditUserScreen(user: user)),
                );
              },
            ),
          );
        },
      ),

      // Bouton flottant pour ajouter un nouvel utilisateur
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers l'écran d'ajout (mode création)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditUserScreen()),
          );
        },
        backgroundColor: buttonColor,
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}