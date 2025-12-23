import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddEditUserScreen extends ConsumerStatefulWidget {
  final String? userId;

  const AddEditUserScreen({super.key, this.userId});

  @override
  ConsumerState<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends ConsumerState<AddEditUserScreen> {
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  String _selectedRole = 'Vendeur'; // Rôle par défaut

  final List<String> _roles = ['Administrateur', 'Gérant', 'Vendeur'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.userId != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(isEditing ? "Modifier l'utilisateur" : "Nouvel Utilisateur",
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Identité"),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _nameController,
                label: "Nom complet",
                hint: "Ex: Moussa Diop",
                icon: Icons.person_outline,
                validator: (v) => v!.isEmpty ? "Nom requis" : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: "Email / Identifiant",
                hint: "moussa@boutique.com",
                icon: Icons.alternate_email,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 32),
              _buildSectionTitle("Accès et Permissions"),
              const SizedBox(height: 16),

              // --- SÉLECTION DU RÔLE ---
              const Text("Rôle de l'utilisateur", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  prefixIcon: const Icon(Icons.shield_outlined),
                ),
                items: _roles.map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
                onChanged: (value) => setState(() => _selectedRole = value!),
              ),

              const SizedBox(height: 32),
              _buildRoleInfoCard(), // Petit résumé des permissions

              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _saveUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A85FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(isEditing ? "METTRE À JOUR" : "CRÉER L'ACCÈS",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title.toUpperCase(),
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade500, letterSpacing: 1.1));
  }

  Widget _buildRoleInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _getRoleDescription(),
              style: TextStyle(color: Colors.blue.shade900, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  String _getRoleDescription() {
    switch (_selectedRole) {
      case 'Administrateur': return "Accès total : peut gérer les entreprises, les stocks et les utilisateurs.";
      case 'Gérant': return "Accès gestion : peut modifier les stocks et voir les rapports de vente.";
      case 'Vendeur': return "Accès restreint : peut uniquement effectuer des ventes et ajouter des clients.";
      default: return "";
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
          ),
        ),
      ],
    );
  }

  void _saveUser() {
    if (_formKey.currentState!.validate()) {
      context.pop();
    }
  }
}