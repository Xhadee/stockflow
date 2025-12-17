import 'package:flutter/material.dart';

class AddMovementScreen extends StatefulWidget {
  static const String routeName = '/add-movement';

  const AddMovementScreen({super.key});

  @override
  State<AddMovementScreen> createState() => _AddMovementScreenState();
}

class _AddMovementScreenState extends State<AddMovementScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  // Palette StockFlow
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  String _selectedProduct = 'Produit A';
  String _movementType = 'Entrée';

  // Liste mock produits
  final List<String> _products = ['Produit A', 'Produit B', 'Produit C'];

  @override
  void dispose() {
    _quantityController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: secondaryColor),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Ajouter un mouvement'),
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Décoration
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.35),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Carte formulaire
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.15),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Produit
                        DropdownButtonFormField<String>(
                          value: _selectedProduct,
                          decoration: _inputDecoration('Produit', Icons.inventory_2),
                          items: _products
                              .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedProduct = val;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 20),

                        // Type mouvement
                        DropdownButtonFormField<String>(
                          value: _movementType,
                          decoration: _inputDecoration('Type', Icons.swap_vert),
                          items: ['Entrée', 'Sortie']
                              .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _movementType = val;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 20),

                        // Quantité
                        TextFormField(
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          decoration:
                          _inputDecoration('Quantité', Icons.confirmation_num),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer une quantité';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Quantité invalide';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Commentaire
                        TextFormField(
                          controller: _commentController,
                          decoration:
                          _inputDecoration('Commentaire', Icons.comment),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Bouton Enregistrer
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: Colors.white,
                        padding:
                        const EdgeInsets.symmetric(vertical: 18),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: Enregistrer mouvement via BLoC / Firestore
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Enregistrer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
