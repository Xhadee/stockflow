import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddEditCustomerScreen extends ConsumerStatefulWidget {
  final String? customerId; // Si null = Ajout, si non null = Edition

  const AddEditCustomerScreen({super.key, this.customerId});

  @override
  ConsumerState<AddEditCustomerScreen> createState() => _AddEditCustomerScreenState();
}

class _AddEditCustomerScreenState extends ConsumerState<AddEditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs pour les champs de saisie
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    // Initialisation (si customerId existe, on chargerait les données ici)
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // Logique de sauvegarde via un provider Riverpod
      // ref.read(customerProvider.notifier).save(...)

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.customerId == null ? 'Client ajouté' : 'Client modifié')),
      );
      context.pop(); // Retour à la liste
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.customerId != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(isEditing ? "Modifier le client" : "Nouveau client",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: _saveForm,
            child: const Text("ENREGISTRER", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2A85FF))),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Informations personnelles"),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _nameController,
                label: "Nom complet",
                hint: "Ex: Seydou Diallo",
                icon: Icons.person_outline,
                validator: (value) => value!.isEmpty ? "Entrez un nom" : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: "Téléphone",
                hint: "Ex: 77 000 00 00",
                icon: Icons.phone_android,
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? "Entrez un numéro" : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: "Email",
                hint: "client@email.com",
                icon: Icons.alternate_email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 32),
              _buildSectionTitle("Adresse & Localisation"),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _addressController,
                label: "Adresse de livraison",
                hint: "Quartier, Rue, Porte...",
                icon: Icons.location_on_outlined,
                maxLines: 3,
              ),
              const SizedBox(height: 40),
              if (isEditing)
                Center(
                  child: TextButton.icon(
                    onPressed: () { /* Logique de suppression */ },
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text("Supprimer ce client", style: TextStyle(color: Colors.red)),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  // Helper pour les titres de section
  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade500,
        letterSpacing: 1.1,
      ),
    );
  }

  // Helper pour construire les champs de texte stylisés
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
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
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
          ),
        ),
      ],
    );
  }
}