import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddEditEnterpriseScreen extends ConsumerStatefulWidget {
  final String? enterpriseId; // null = Création, sinon = Edition

  const AddEditEnterpriseScreen({super.key, this.enterpriseId});

  @override
  ConsumerState<AddEditEnterpriseScreen> createState() => _AddEditEnterpriseScreenState();
}

class _AddEditEnterpriseScreenState extends ConsumerState<AddEditEnterpriseScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();

    // Si on est en mode édition, on chargerait les données ici
    // if (widget.enterpriseId != null) { ... }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.enterpriseId != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          isEditing ? "Modifier l'entreprise" : "Nouvelle entreprise",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => context.go('/dashboard'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SELECTION DU LOGO (Placeholder) ---
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade100,
                      child: const Icon(Icons.storefront, size: 40, color: Colors.grey),
                    ),
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
              const SizedBox(height: 40),

              _buildFieldLabel("Nom de l'entreprise"),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _nameController,
                hint: "Ex: Ma Super Boutique",
                icon: Icons.business,
                validator: (v) => v!.isEmpty ? "Le nom est requis" : null,
              ),

              const SizedBox(height: 24),

              _buildFieldLabel("Numéro de téléphone"),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _phoneController,
                hint: "Ex: +221 77 000 00 00",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 24),

              _buildFieldLabel("Adresse physique"),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _addressController,
                hint: "Dakar, Plateau...",
                icon: Icons.location_on,
                maxLines: 2,
              ),

              const SizedBox(height: 48),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _saveEnterprise,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A85FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text(
                    isEditing ? "METTRE À JOUR" : "CRÉER L'ENTREPRISE",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, size: 20, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }

  void _saveEnterprise() {
    if (_formKey.currentState!.validate()) {
      // Logique Riverpod : ref.read(enterprisesProvider.notifier).add(...)
      context.pop();
    }
  }
}