// lib/screens/products/add_edit_product_screen.dart

import 'package:flutter/material.dart';
import '../../models/product_model.dart'; // <--- Chemin corrigé
// import 'product_list_screen.dart'; // Retiré car non directement utilisé

class AddEditProductScreen extends StatefulWidget {
  static const String routeName = '/add-edit-product';
  final Product? product; // Si un produit est passé, c'est une édition

  const AddEditProductScreen({this.product, super.key});

  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs
  late TextEditingController _nameController;
  late TextEditingController _skuController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _descriptionController;

  // Palette de couleurs (maintenue)
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color buttonColor = const Color(0xFFD6955B);

  bool get isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    // Initialiser les contrôleurs avec les données existantes si en mode édition
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _skuController = TextEditingController(text: widget.product?.sku ?? '');
    // S'assurer que le prix et la quantité sont bien des chaînes pour le TextEditingController
    _priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
    _quantityController = TextEditingController(text: widget.product?.quantity.toString() ?? '');
    _descriptionController = TextEditingController(text: widget.product?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Style des champs de texte (réutilisé pour la cohérence)
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: secondaryColor.withOpacity(0.8)),
      prefixIcon: Icon(icon, color: secondaryColor),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.white, width: 0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorStyle: TextStyle(fontSize: 14, color: Colors.red),
    );
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      // Logique de sauvegarde ou de mise à jour (à connecter à votre BDD)
      final String action = isEditing ? 'mis à jour' : 'ajouté';

      // Création/Mise à jour d'un objet Product (simulé)
      /*
      final Product newOrUpdatedProduct = Product(
        id: widget.product?.id ?? UniqueKey().toString(), // Générer un ID si nouveau
        name: _nameController.text,
        sku: _skuController.text,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
      );
      // Appelez votre service ici pour enregistrer (ex: ProductService.save(newOrUpdatedProduct))
      */

      // Feedback visuel
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produit "${_nameController.text}" $action avec succès !'),
          backgroundColor: secondaryColor,
        ),
      );

      // Retourner à l'écran précédent (liste ou détail)
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          isEditing ? 'Modifier le Produit' : 'Ajouter un Produit',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Champ Nom ---
              _buildTextField(
                controller: _nameController,
                label: 'Nom du Produit',
                icon: Icons.inventory_2_rounded,
                validator: (value) => value == null || value.isEmpty ? 'Le nom est requis' : null,
              ),

              // --- Champ SKU ---
              _buildTextField(
                controller: _skuController,
                label: 'Code SKU (Unique)',
                icon: Icons.qr_code,
                validator: (value) => value == null || value.isEmpty ? 'Le SKU est requis' : null,
              ),

              // --- Prix et Quantité (Row) ---
              Row(
                children: [
                  // Champ Prix
                  Expanded(
                    child: _buildTextField(
                      controller: _priceController,
                      label: 'Prix (€)',
                      icon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || double.tryParse(value) == null) {
                          return 'Prix invalide';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Champ Quantité
                  Expanded(
                    child: _buildTextField(
                      controller: _quantityController,
                      label: 'Quantité',
                      icon: Icons.layers,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || int.tryParse(value) == null) {
                          return 'Quantité invalide';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              // --- Champ Description ---
              _buildTextField(
                controller: _descriptionController,
                label: 'Description du Produit',
                icon: Icons.description,
                maxLines: 4,
                validator: (value) => null, // Optionnel
              ),

              const SizedBox(height: 30),

              // Bouton de sauvegarde
              ElevatedButton(
                onPressed: _saveProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  isEditing ? 'Sauvegarder les Modifications' : 'Ajouter le Produit',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget utilitaire pour les champs de texte
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldValidator<String> validator,
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        decoration: _inputDecoration(label, icon),
      ),
    );
  }
}