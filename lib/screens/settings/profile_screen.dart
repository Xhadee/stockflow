import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/user_provider.dart';
// Importez votre provider d'authentification
// import '../../providers/auth_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // On initialise avec les données actuelles du selectedUser
    final user = ref.read(selectedUserProvider);
    _nameController = TextEditingController(text: user?.name ?? "");
    _emailController = TextEditingController(text: user?.email ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(selectedUserProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Mon Profil",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () {
            context.pop();
            context.push('/settings');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit_outlined,
                color: const Color(0xFF2A85FF)),
            onPressed: () {
              if (_isEditing) {
                // Logique de sauvegarde ici
                setState(() => _isEditing = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profil mis à jour")),
                );
              } else {
                setState(() => _isEditing = true);
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // --- HEADER AVATAR ---
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFFF0F7FF),
                    child: Text(
                      user?.name.substring(0, 1).toUpperCase() ?? "?",
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF2A85FF)),
                    ),
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: Color(0xFF2A85FF), shape: BoxShape.circle),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // --- FORMULAIRE ---
            _buildProfileField(
              label: "Nom complet",
              controller: _nameController,
              icon: Icons.person_outline,
              enabled: _isEditing,
            ),
            const SizedBox(height: 20),
            _buildProfileField(
              label: "Adresse Email",
              controller: _emailController,
              icon: Icons.email_outlined,
              enabled: _isEditing,
            ),

            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),

            // --- INFO RÔLE (Non modifiable par l'utilisateur lui-même) ---
            _buildInfoTile("Rôle", "Administrateur système", Icons.shield_outlined),
            _buildInfoTile("Dernière connexion", "Aujourd'hui, 14:30", Icons.history),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool enabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          style: const TextStyle(fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20),
            filled: true,
            fillColor: enabled ? Colors.grey.shade50 : Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: enabled ? BorderSide(color: Colors.grey.shade200) : BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          )
        ],
      ),
    );
  }
}