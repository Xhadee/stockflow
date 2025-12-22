import 'package:flutter/material.dart';
import 'package:stockflow/screens/auth/welcome_screen.dart';
import 'login_screen.dart';
import '../layout/layout.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Utiliser une variable d'état pour le mot de passe et la confirmation
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Palette de couleurs (maintenue)
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  // Style des champs de texte (réutilisé du LoginScreen)
  InputDecoration _inputDecoration(String label, IconData icon, {IconButton? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: secondaryColor.withOpacity(0.8)),
      prefixIcon: Icon(icon, color: secondaryColor),
      suffixIcon: suffixIcon, // Ajout du suffixIcon pour la visibilité du mot de passe
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

  // Widget réutilisable pour les champs de formulaire avec ombre (réutilisé du LoginScreen)
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    bool obscureText = false,
    required FormFieldValidator<String> validator,
    required VoidCallback? toggleVisibility,
    required bool isConfirmPassword,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20), // Marge en bas
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
        obscureText: obscureText,
        validator: validator,
        decoration: _inputDecoration(
          label,
          icon,
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: secondaryColor,
            ),
            onPressed: toggleVisibility,
          )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // Ajout de l'AppBar pour la flèche de retour et la cohérence
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        title: Text(
          "Inscription",
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Décoration de l'arrière-plan (forme en haut à gauche pour la variété)
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Contenu du formulaire
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10), // Espace après l'AppBar

                  // --- Icône d'Inscription ---
                  Icon(
                    Icons.app_registration, // Icône plus spécifique à l'enregistrement
                    size: 90,
                    color: primaryColor,
                  ),
                  SizedBox(height: 10),

                  // --- Titre ---
                  Text(
                    'Rejoignez StockFlow',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    'Créez votre compte en quelques étapes.',
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryColor.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 40),

                  // --- Formulaire ---
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Nom complet
                        _buildTextField(
                          controller: _nameController,
                          label: 'Nom complet',
                          icon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre nom';
                            }
                            return null;
                          },
                          isPassword: false,
                          obscureText: false,
                          toggleVisibility: null,
                          isConfirmPassword: false,
                        ),

                        // Email
                        _buildTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty || !value.contains('@')) {
                              return 'Veuillez entrer un email valide';
                            }
                            return null;
                          },
                          isPassword: false,
                          obscureText: false,
                          toggleVisibility: null,
                          isConfirmPassword: false,
                        ),

                        // Mot de passe
                        _buildTextField(
                          controller: _passwordController,
                          label: 'Mot de passe',
                          icon: Icons.lock,
                          isPassword: true,
                          obscureText: _obscurePassword,
                          toggleVisibility: () {
                            setState(() { _obscurePassword = !_obscurePassword; });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 6) {
                              return 'Le mot de passe doit avoir au moins 6 caractères';
                            }
                            return null;
                          },
                          isConfirmPassword: false,
                        ),

                        // Confirmer mot de passe
                        _buildTextField(
                          controller: _confirmPasswordController,
                          label: 'Confirmer le mot de passe',
                          icon: Icons.lock,
                          isPassword: true,
                          obscureText: _obscureConfirmPassword,
                          toggleVisibility: () {
                            setState(() { _obscureConfirmPassword = !_obscureConfirmPassword; });
                          },
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Les mots de passe ne correspondent pas';
                            }
                            return null;
                          },
                          isConfirmPassword: true,
                        ),

                        SizedBox(height: 20),

                        // Bouton d'Inscription
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Logique d'inscription (simulée)
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => WelcomeScreen()),
                              );
                            }
                          },
                          child: Text(
                            "S'inscrire",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 30),

                        // Lien vers la connexion
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Déjà un compte ?',
                              style: TextStyle(color: secondaryColor),
                            ),
                            TextButton(
                              onPressed: () {
                                // Utilisation de pushReplacement pour ne pas empiler l'écran d'inscription
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => LoginScreen()),
                                );
                              },
                              child: Text(
                                'Se connecter',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20), // Espace en bas
                      ],
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