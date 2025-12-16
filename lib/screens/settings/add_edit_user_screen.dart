import 'package:flutter/material.dart';

class AddEditUserScreen extends StatefulWidget {
  // Le paramètre 'user' est optionnel. S'il est fourni, c'est une modification.
  final Map<String, dynamic>? user;

  const AddEditUserScreen({this.user, super.key});

  @override
  _AddEditUserScreenState createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController; // Utilisé uniquement en mode ajout ou pour la réinitialisation
  late String _selectedRole;

  // Liste des rôles
  final List<String> _roles = ['Administrateur', 'Gestionnaire Stock', 'Vendeur', 'Consultant'];

  // Palette de couleurs
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color buttonColor = const Color(0xFFD6955B);

  bool get isEditing => widget.user != null;

  @override
  void initState() {
    super.initState();
    // Initialiser les contrôleurs
    _nameController = TextEditingController(text: widget.user?['name'] ?? '');
    _emailController = TextEditingController(text: widget.user?['email'] ?? '');
    _passwordController = TextEditingController(); // Laisser vide par défaut
    _selectedRole = widget.user?['role'] ?? 'Vendeur';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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

  void _saveUser() {
    if (_formKey.currentState!.validate()) {
      final String action = isEditing ? 'mis à jour' : 'créé';
      final String userName = _nameController.text;

      // Logique de sauvegarde (simulée) : Enregistrer les données...
      // En mode édition, le mot de passe n'est sauvegardé que s'il est rempli (réinitialisation).

      // Feedback visuel
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Utilisateur "$userName" $action avec succès. Rôle: $_selectedRole.'),
          backgroundColor: secondaryColor,
        ),
      );

      // Retour à la gestion des utilisateurs
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
          isEditing ? 'Modifier Utilisateur' : 'Ajouter un Utilisateur',
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
              // --- Champ Nom Complet ---
              _buildTextField(
                controller: _nameController,
                label: 'Nom Complet',
                icon: Icons.person,
                validator: (value) => value == null || value.isEmpty ? 'Le nom est requis' : null,
              ),

              // --- Champ Email ---
              _buildTextField(
                controller: _emailController,
                label: 'Adresse Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'L\'email est requis';
                  if (!value.contains('@')) return 'Format email invalide';
                  return null;
                },
              ),

              // --- Champ Mot de Passe ---
              // Requis pour la création, optionnel pour l'édition (pour la réinitialisation)
              _buildTextField(
                controller: _passwordController,
                label: isEditing ? 'Réinitialiser Mot de Passe (laisser vide pour ne pas changer)' : 'Mot de Passe',
                icon: Icons.lock,
                isPassword: true,
                validator: (value) {
                  if (!isEditing && (value == null || value.isEmpty)) {
                    return 'Le mot de passe est requis pour la création';
                  }
                  if (value != null && value.isNotEmpty && value.length < 6) {
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
              ),

              // --- Sélecteur de Rôle ---
              _buildRoleDropdown(),

              // --- Bouton de sauvegarde ---
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveUser,
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
                  isEditing ? 'Sauvegarder l\'Utilisateur' : 'Créer l\'Utilisateur',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget utilitaire pour les champs de texte (réutilisé de l'écran d'organisation)
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldValidator<String> validator,
    bool isPassword = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        obscureText: isPassword,
        decoration: _inputDecoration(label, icon),
      ),
    );
  }

  // Widget utilitaire pour le sélecteur de rôle
  Widget _buildRoleDropdown() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.1), blurRadius: 10)],
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedRole,
        decoration: const InputDecoration(
          labelText: 'Rôle de l\'Utilisateur',
          prefixIcon: Icon(Icons.badge, color: Color(0xFF226D68)),
          border: InputBorder.none,
        ),
        items: _roles.map((String role) {
          return DropdownMenuItem<String>(
            value: role,
            child: Text(role),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _selectedRole = newValue!;
          });
        },
      ),
    );
  }
}