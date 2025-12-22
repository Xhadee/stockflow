import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddEditSupplierScreen extends ConsumerStatefulWidget {
  final String? supplierId;

  const AddEditSupplierScreen({super.key, this.supplierId});

  @override
  ConsumerState<AddEditSupplierScreen> createState() => _AddEditSupplierScreenState();
}

class _AddEditSupplierScreenState extends ConsumerState<AddEditSupplierScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _contactNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _categoryController; // Ex: Électronique, Boissons, etc.

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _contactNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _categoryController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.supplierId != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          isEditing ? "Modifier le fournisseur" : "Nouveau fournisseur",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: _saveSupplier,
            child: const Text("ENREGISTRER",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2A85FF))),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Informations Entreprise"),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _nameController,
                label: "Nom de l'entreprise",
                hint: "Ex: Samsung Electronics Sénégal",
                icon: Icons.business_outlined,
                validator: (v) => v!.isEmpty ? "Nom requis" : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _categoryController,
                label: "Type de produits fournis",
                hint: "Ex: Matériel Informatique",
                icon: Icons.category_outlined,
              ),

              const SizedBox(height: 32),
              _buildSectionTitle("Contact Principal"),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _contactNameController,
                label: "Nom du contact",
                hint: "Ex: M. Jean Faye",
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: "Téléphone",
                hint: "+221 33 000 00 00",
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: "Email",
                hint: "contact@fournisseur.sn",
                icon: Icons.alternate_email,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 32),
              _buildSectionTitle("Localisation"),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _addressController,
                label: "Adresse",
                hint: "Dakar, Rue 10 x Lamine Gueye",
                icon: Icons.location_on_outlined,
                maxLines: 2,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade500, letterSpacing: 1.1),
    );
  }

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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
          ),
        ),
      ],
    );
  }

  void _saveSupplier() {
    if (_formKey.currentState!.validate()) {
      // Logique de sauvegarde ici
      context.pop();
    }
  }
}