import 'package:flutter/material.dart';
import '../auth/login_screen.dart'; // Pour la déconnexion
import 'user_management_screen.dart'; // Étape suivante : Gestion des utilisateurs

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';

  const SettingsScreen({super.key});

  // Palette de couleurs (maintenue)
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color buttonColor = const Color(0xFFD6955B);
  final Color accentColor = const Color(0xFFFEEAA1);

  // Widget utilitaire pour créer des sections de paramètres
  Widget _buildSettingsSection({
    required BuildContext context,
    required String title,
    required List<Widget> tiles,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: tiles,
            ),
          ),
        ],
      ),
    );
  }

  // Widget utilitaire pour créer un élément de paramètre cliquable
  Widget _buildSettingsTile({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
    String? subtitle,
    Color iconColor = const Color(0xFF226D68),
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: primaryColor)),
      subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: secondaryColor.withOpacity(0.7))) : null,
      trailing: onTap != null ? Icon(Icons.chevron_right, color: buttonColor) : null,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Paramètres', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Section COMPTE ET ACCÈS ---
            _buildSettingsSection(
              context: context,
              title: 'Compte et Accès',
              tiles: [
                _buildSettingsTile(
                  title: 'Gérer les Utilisateurs',
                  icon: Icons.people_alt,
                  onTap: () {
                    // Navigation vers l'écran de gestion des utilisateurs
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const UserManagementScreen()),
                    );
                  },
                ),
                _buildSettingsTile(
                  title: 'Mon Profil',
                  icon: Icons.person,
                  subtitle: 'Mettre à jour le mot de passe et l\'email',
                  onTap: () {
                    // TODO: Naviguer vers l'édition du profil utilisateur
                  },
                ),
              ],
            ),

            // --- Section GESTION DES DONNÉES ---
            _buildSettingsSection(
              context: context,
              title: 'Gestion des Données',
              tiles: [
                _buildSettingsTile(
                  title: 'Unités de Mesure',
                  icon: Icons.scale,
                  subtitle: 'Gérer les unités de stock (Kg, L, Pièce, etc.)',
                  onTap: () {
                    // TODO: Naviguer vers la gestion des unités
                  },
                ),
                _buildSettingsTile(
                  title: 'Configuration des Alertes',
                  icon: Icons.notification_important,
                  subtitle: 'Seuil de stock bas (ex: < 10 articles)',
                  onTap: () {
                    // TODO: Naviguer vers la configuration des seuils d'alerte
                  },
                ),
              ],
            ),

            // --- Section SÉCURITÉ ET DIVERS ---
            _buildSettingsSection(
              context: context,
              title: 'Sécurité et Divers',
              tiles: [
                _buildSettingsTile(
                  title: 'Historique des Connexions',
                  icon: Icons.security,
                  onTap: () {
                    // TODO: Naviguer vers l'historique de sécurité
                  },
                ),
                _buildSettingsTile(
                  title: 'Déconnexion',
                  icon: Icons.logout,
                  iconColor: Colors.redAccent,
                  onTap: () {
                    // Déconnexion complète
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) =>  LoginScreen()),
                          (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}