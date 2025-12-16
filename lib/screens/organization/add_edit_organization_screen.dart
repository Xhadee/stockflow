import 'package:flutter/material.dart';

class AddEditOrganizationScreen extends StatefulWidget {
  final Map<String, String>? organization; // null si ajout, non null si modification

  const AddEditOrganizationScreen({this.organization, super.key});

  @override
  _AddEditOrganizationScreenState createState() => _AddEditOrganizationScreenState();
}

class _AddEditOrganizationScreenState extends State<AddEditOrganizationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _contactController;

  // Palette de couleurs
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color buttonColor = const Color(0xFFD6955B);

  bool get isEditing => widget.organization != null;

  @override
  void initState() {
    super.initState();
    // Initialiser les contrôleurs
    _nameController = TextEditingController(text: widget.organization?['name'] ?? '');
    _locationController = TextEditingController(text: widget.organization?['location'] ?? '');
    _contactController = TextEditingController(text: widget.organization?['contact'] ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  // Style des champs de texte
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: secondaryColor.withOpacity(0.8)),
      prefixIcon: Icon(icon, color: secondaryColor),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: primaryColor, width: 2)),
    );
  }

  void _saveOrganization() {
    if (_formKey.currentState!.validate()) {
      final String action = isEditing ? 'mise à jour' : 'ajoutée';
      final String orgName = _nameController.text;

      // Logique de sauvegarde (simulée) : Enregistrer les données...

      // Feedback visuel
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Organisation "$orgName" $action avec succès.'),
          backgroundColor: secondaryColor,
        ),
      );

      // Retour à la liste
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
          isEditing ? 'Modifier l\'Organisation' : 'Ajouter une Organisation',
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
              // --- Champ Nom de l'Organisation ---
              _buildTextField(
                controller: _nameController,
                label: 'Nom de l\'Organisation',
                icon: Icons.factory,
                validator: (value) => value == null || value.isEmpty ? 'Le nom est requis' : null,
              ),

              // --- Champ Localisation ---
              _buildTextField(
                controller: _locationController,
                label: 'Localisation/Ville',
                icon: Icons.location_on,
                validator: (value) => null, // Optionnel
              ),

              // --- Champ Contact Principal ---
              _buildTextField(
                controller: _contactController,
                label: 'Contact (Email ou Téléphone)',
                icon: Icons.contact_mail,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => null, // Optionnel
              ),

              const SizedBox(height: 30),

              // Bouton de sauvegarde
              ElevatedButton(
                onPressed: _saveOrganization,
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
                  isEditing ? 'Sauvegarder les Modifications' : 'Ajouter l\'Organisation',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
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
        validator: validator,
        decoration: _inputDecoration(label, icon),
      ),
    );
  }
}