import 'package:flutter/material.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Palette de couleurs (maintenue)
  final Color primaryColor = const Color(0xFF18534F); // Vert foncé principal
  final Color secondaryColor = const Color(0xFF226D68); // Vert moyen/foncé
  final Color backgroundColor = const Color(0xFFECF8F6); // Arrière-plan très clair
  final Color accentColor = const Color(0xFFFEEAA1); // Jaune/Crème
  final Color buttonColor = const Color(0xFFD6955B); // Orange/Brun

  // Style des champs de texte pour l'esthétique
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: secondaryColor.withOpacity(0.8)),
      prefixIcon: Icon(icon, color: secondaryColor),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15), // Bords plus arrondis
        borderSide: BorderSide.none, // Retirer la bordure par défaut
      ),
      // Ajout d'une ombre subtile pour l'effet 'carte'
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.white, width: 0), // Pas de bordure visible
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: primaryColor, width: 2), // Bordure colorée au focus
      ),
      errorStyle: TextStyle(fontSize: 14, color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      body: Stack(
        children: [
          // Décoration de l'arrière-plan (forme en bas à droite)
          Positioned(
            bottom: -80,
            right: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Contenu du formulaire et des boutons
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),

                  // --- Icône de Connexion ---
                  Icon(
                    Icons.fingerprint_rounded, // Icône moderne pour l'authentification
                    size: 110,
                    color: primaryColor,
                  ),
                  SizedBox(height: 15),

                  // --- Titre ---
                  Text(
                    'Bienvenue',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    'Connectez-vous à votre compte StockFlow',
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
                        // Email
                        Container(
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
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: _inputDecoration('Email', Icons.email),
                            validator: (value) {
                              if (value == null || value.isEmpty || !value.contains('@')) {
                                return 'Veuillez entrer un email valide';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20), // Espace augmenté

                        // Password
                        Container(
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
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: _inputDecoration('Mot de passe', Icons.lock).copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                  color: secondaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre mot de passe';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 15),

                        // Mot de passe oublié
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Utilisation des routes nommées est recommandée : Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => ForgotPasswordScreen()),
                              );
                            },
                            child: Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(color: buttonColor, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(height: 25), // Espace avant le bouton

                        // Bouton de Connexion
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            elevation: 8, // Ombre plus prononcée pour le CTA
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Logique de connexion (simulée)
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => HomeScreen()),
                              );
                            }
                          },
                          child: Text(
                            'Se connecter',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 30),

                        // Lien vers l'inscription
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pas encore de compte ?',
                              style: TextStyle(color: secondaryColor),
                            ),
                            TextButton(
                              onPressed: () {
                                // Utilisation des routes nommées est recommandée : Navigator.pushNamed(context, RegisterScreen.routeName);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => RegisterScreen()),
                                );
                              },
                              child: Text(
                                "S'inscrire ici",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
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