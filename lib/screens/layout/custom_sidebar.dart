import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stockflow/providers/user_provider.dart';

import '../../utils/app_colors.dart';
import '../../providers/entreprises_provider.dart';


class CustomSidebar extends ConsumerWidget {
  const CustomSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allEnterprises = ref.watch(enterprisesProvider);
    final selectedEnterprise = ref.watch(selectedEnterpriseProvider);
    final selectedUser = ref.watch(selectedUserProvider);

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header de la Sidebar
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey.shade50),
            child: Row(
              children: [
                Padding(padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () { context.push('/profile-setting'); },
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Text(selectedUser.name.substring(0, 1).toUpperCase() ?? "?", style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                        selectedUser.name ?? "?Utilisateur",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(
                        selectedUser.email ?? "?Email",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ],
                ),)
              ],
            )
          ),

          // Section Entreprises
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("MES ENTREPRISES", style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, size: 20, color: AppColors.primary),
                  onPressed: () {
                    Navigator.pop(context);
                    context.go('/add-enterprise');
                  },
                )
              ],
            ),
          ),

          // Liste des entreprises
          ...allEnterprises.map((enterprise) => ListTile(
            leading: CircleAvatar(child: Text(enterprise.logo)),
            title: selectedEnterprise.id == enterprise.id
                ? Text(enterprise.name, style: TextStyle(fontWeight: FontWeight.bold))
                : Text(enterprise.name),
            // On affiche une coche si c'est l'entreprise active
            trailing: selectedEnterprise.id == enterprise.id
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            onTap: () {
              // 1. Changer l'entreprise active
              ref.read(selectedEnterpriseProvider.notifier).state = enterprise;
              // 2. Rediriger vers le dashboard
              context.go('/dashboard');
              // 3. Fermer le drawer
              Navigator.pop(context);
            },
          )).toList(),

          const Divider(),

          // Paramètres (déplacé ici)
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text("Paramètres"),
            onTap: () {
              Navigator.pop(context);
              context.push('/settings');
            },
          ),

          const Spacer(), // Pousse le bouton déconnexion vers le bas

          // Bouton Déconnexion
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text("Déconnexion", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600)),
            onTap: () {
              // Logique de déconnexion
              //TODO changer le selectedUser en null
              //TODO Rediriger vers la page de deconnexion

              context.go('/logout');
              //TODO Fermer le sidebar
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}