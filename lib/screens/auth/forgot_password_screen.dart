import 'package:flutter/material.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot-password';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  // Palette de couleurs (maintenue)
  final Color primaryColor = const Color(0xFF18534F); // Vert foncé principal
  final Color secondaryColor = const Color(0xFF226D68); // Vert moyen/foncé
  final Color backgroundColor = const Color(0xFFECF8F6); // Arrière-plan très clair
  final Color accentColor = const Color(0xFFFEEAA1); // Jaune/Crème (pour la décoration)
  final Color buttonColor = const Color(0xFFD6955B); // Orange/Brun

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // AppBar pour la flèche de retour élégante
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        title: Text(
          "Réinitialisation",
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Décoration de l'arrière-plan (forme en bas à gauche)
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Contenu principal (scrollable)
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),

                  // --- Icône de Réinitialisation ---
                  Icon(
                    Icons.lock_reset, // Icône moderne pour la réinitialisation
                    size: 110,
                    color: primaryColor,
                  ),
                  SizedBox(height: 20),

                  // --- Titre et Description ---
                  Text(
                    'Mot de passe oublié ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Entrez l\'adresse e-mail associée à votre compte pour recevoir le lien de réinitialisation.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
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
                        SizedBox(height: 30),

                        // Bouton d'Envoi
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
                              // Simuler l'envoi du lien
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Lien envoyé à ${_emailController.text}. Vérifiez vos spams !'),
                                  backgroundColor: secondaryColor,
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Envoyer le lien',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 30),

                        // Lien de retour
                        TextButton(
                          onPressed: () {
                            // Utilisation de pushReplacement pour revenir à la connexion et vider l'historique
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                            );
                          },
                          child: Text(
                            '← Retour à la connexion',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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