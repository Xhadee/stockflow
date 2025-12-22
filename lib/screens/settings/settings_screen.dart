import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/settings_widgets/build_section_title.dart';
import '../../widgets/settings_widgets/build_settings_group.dart';
import '../../widgets/settings_widgets/build_settings_tile.dart';


class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          "Paramètres",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildSectionTitle("Compte"),
          buildSettingsGroup([
            buildSettingsTile(
              icon: Icons.person_outline,
              title: "Profil",
              subtitle: "Modifier vos informations personnelles",
              onTap: () {
                context.push('/profile-setting');
              },
            ),
            buildSettingsTile(
              icon: Icons.lock_outline,
              title: "Sécurité",
              subtitle: "Mot de passe et authentification",
              onTap: () {},
            ),
          ]),

          const SizedBox(height: 24),
          buildSectionTitle("Application"),
          buildSettingsGroup([
            buildSettingsTile(
              icon: Icons.notifications_none,
              title: "Notifications",
              subtitle: "Alertes de stock et rappels",
              onTap: () {
                context.push('/movement-alerts');
              },
            ),
            // buildSettingsTile(
            //   icon: Icons.dark_mode_outlined,
            //   title: "Apparence",
            //   subtitle: "Mode clair / sombre",
            //   trailing: Switch(value: false, onChanged: (val) {}),
            // ),
            buildSettingsTile(
              icon: Icons.language,
              title: "Langue",
              subtitle: "Français (Sénégal)",
              onTap: () {
                context.push('/language-setting');
              },
            ),
          ]),

          const SizedBox(height: 24),
          buildSectionTitle("Assistance"),
          buildSettingsGroup([
            buildSettingsTile(
              icon: Icons.help_outline,
              title: "Centre d'aide",
              onTap: () {},
            ),
            buildSettingsTile(
              icon: Icons.info_outline,
              title: "À propos",
              subtitle: "Version 1.0.0",
              onTap: () {},
            ),
          ]),

          const SizedBox(height: 32),
          // Bouton Déconnexion
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              onTap: () {
                context.go('/logout');
              },
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Déconnexion",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }






}