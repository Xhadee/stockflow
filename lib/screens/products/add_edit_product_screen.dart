import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddEditProductScreen extends ConsumerStatefulWidget {
  final String? productId; // null = Création, sinon = Edition

  const AddEditProductScreen({super.key, this.productId});

  @override
  ConsumerState<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends ConsumerState<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _minStockController;
  late TextEditingController _initialStockController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _minStockController = TextEditingController();
    _initialStockController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _minStockController.dispose();
    _initialStockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.productId != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          isEditing ? "Modifier le produit" : "Nouveau produit",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: _saveProduct,
            child: const Text("ENREGISTRER",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2A85FF))),
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
              // --- IMAGE DU PRODUIT ---
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Icon(Icons.add_a_photo_outlined, size: 40, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 32),

              _buildSectionTitle("Informations Générales"),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _nameController,
                label: "Nom du produit",
                hint: "Ex: Clavier Mécanique RGB",
                icon: Icons.shopping_bag_outlined,
                validator: (v) => v!.isEmpty ? "Nom requis" : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _priceController,
                label: "Prix de vente (FCFA)",
                hint: "Ex: 45000",
                icon: Icons.payments_outlined,
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Prix requis" : null,
              ),

              const SizedBox(height: 32),
              _buildSectionTitle("Gestion des Stocks"),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _minStockController,
                      label: "Seuil d'alerte",
                      hint: "Ex: 5",
                      icon: Icons.warning_amber_rounded,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (!isEditing) // On ne modifie le stock initial qu'à la création
                    Expanded(
                      child: _buildTextField(
                        controller: _initialStockController,
                        label: "Stock Initial",
                        hint: "Ex: 20",
                        icon: Icons.inventory_2_outlined,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 40),
              if (isEditing)
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () { /* Supprimer le produit */ },
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text("Supprimer le produit", style: TextStyle(color: Colors.red)),
                  ),
                ),
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
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
          ),
        ),
      ],
    );
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      // Logique de sauvegarde
      context.pop();
    }
  }
}