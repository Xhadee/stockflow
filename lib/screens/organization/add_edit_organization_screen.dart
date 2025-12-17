import 'package:flutter/material.dart';

class AddEditOrganizationScreen extends StatefulWidget {
  static const String routeName = '/add-edit-organization';

  final Map<String, dynamic>? organization; // null si création

  const AddEditOrganizationScreen({super.key, this.organization});

  @override
  State<AddEditOrganizationScreen> createState() => _AddEditOrganizationScreenState();
}

class _AddEditOrganizationScreenState extends State<AddEditOrganizationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();

  // Palette StockFlow
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: secondaryColor),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
  void initState() {
    super.initState();
    if (widget.organization != null) {
      _nameController.text = widget.organization!['name'];
      _currencyController.text = widget.organization!['currency'];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _currencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(widget.organization == null ? 'Nouvelle organisation' : 'Modifier organisation'),
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
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Nom organisation
                    TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration('Nom de l’organisation', Icons.business),
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Veuillez entrer un nom';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Devise
                    TextFormField(
                      controller: _currencyController,
                      decoration: _inputDecoration('Devise', Icons.monetization_on),
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Veuillez entrer une devise';
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // Bouton Enregistrer
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: Sauvegarder via BLoC / Firestore
                          Navigator.pop(context, {
                            'name': _nameController.text,
                            'currency': _currencyController.text,
                          });
                        }
                      },
                      child: const Text(
                        'Enregistrer',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Bouton Annuler
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: primaryColor, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Annuler',
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
