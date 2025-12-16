import 'package:flutter/material.dart';
import 'add_edit_organization_screen.dart'; // Étape suivante

class OrganizationListScreen extends StatelessWidget {
  static const String routeName = '/organizations';

  const OrganizationListScreen({super.key});

  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color buttonColor = const Color(0xFFD6955B);

  // Exemple de données : organisations disponibles
  final List<Map<String, String>> organizations = const [
    {"id": "1", "name": "Sonatel DOE", "location": "Dakar, Sénégal"},
    {"id": "2", "name": "IPSL Solutions", "location": "Paris, France"},
    {"id": "3", "name": "Startup XYZ", "location": "Abidjan, Côte d'Ivoire"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Gestion des Organisations'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: organizations.length,
          itemBuilder: (context, index) {
            final org = organizations[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Icon(Icons.business, color: secondaryColor),
                title: Text(
                  org["name"]!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                subtitle: Text(
                  org["location"]!,
                  style: TextStyle(color: secondaryColor.withOpacity(0.7)),
                ),
                trailing: Icon(Icons.edit, color: buttonColor),
                onTap: () {
                  // Naviguer vers l'écran d'édition pour modifier l'organisation
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddEditOrganizationScreen(organization: org),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      // Bouton flottant pour ajouter une nouvelle organisation
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers l'écran d'ajout (mode création)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditOrganizationScreen(),
            ),
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