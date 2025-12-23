import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'login_screen.dart';
import 'register_screen.dart';

// Pour un design plus esthétique, j'ai introduit des modifications
// sur l'arrière-plan, les polices, et les boutons.

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome';

  // Palette de couleurs (maintenue)
  final Color primaryColor = const Color(0xFF18534F); // Vert foncé principal
  final Color secondaryColor = const Color(0xFF226D68); // Vert moyen/foncé
  final Color backgroundColor = const Color(0xFFECF8F6); // Arrière-plan très clair
  // final Color accentColor = const Color(0xFFFEEAA1); // Jaune/Crème (pour la décoration)
  final Color buttonColor = const Color(0xFFD6955B); // Orange/Brun (pour les boutons)

  @override
  Widget build(BuildContext context) {
    // Hauteur de l'écran pour des calculs d'espacement réactifs
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // L'arrière-plan est géré par la pile pour y ajouter des éléments décoratifs
      body: Stack(
        children: [
          // 1. Décoration de l'arrière-plan (forme ou dégradé subtil)
          // Ajout d'une forme en haut (esthétique de 'blob' ou 'vague')
          Positioned(
            top: -screenHeight * 0.1, // Position en dehors de l'écran
            left: -screenHeight * 0.1,
            child: Container(
              width: screenHeight * 0.5,
              height: screenHeight * 0.5,
              decoration: BoxDecoration(
                color: Colors.transparent.withOpacity(0.4), // Couleur accent avec transparence
                shape: BoxShape.circle,
              ),
            ),
          ),

          // 2. Contenu principal (sur le dessus)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch, // Pour que le texte soit au milieu
                children: [
                  Spacer(flex: 2),

                  // --- Zone Logo/Illustration ---
                  // Utilisation d'un Asset si disponible, sinon votre icône
                  // Si vous avez une illustration, remplacez par Image.asset('assets/illustration.png')
                  Icon(
                    Icons.storefront, // Nouvelle icône plus 'moderne'
                    size: 110,
                    color: primaryColor,
                  ),
                  SizedBox(height: 20),

                  // --- Texte de Bienvenue ---
                  Text(
                    'Bienvenue sur',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'StockFlow',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900, // Police très épaisse
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),

                  // --- Description ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Votre solution complète et intuitive pour la gestion intelligente de votre inventaire, stocks, et commandes.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: secondaryColor.withOpacity(0.8),
                        height: 1.5,
                      ),
                    ),
                  ),
                  Spacer(flex: 3), // Plus d'espace pour pousser les boutons vers le bas

                  // --- Boutons ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Bouton 'Se connecter' (Élevé/Rempli)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          elevation: 6, // Ombre plus visible
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // Bords plus arrondis
                          ),
                        ),
                        onPressed: () {
                          context.go('/login');
                        },
                        child: Text(
                          'Se connecter',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Bouton 'S\'inscrire' (Contour)
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: secondaryColor, width: 2), // Contour plus visible
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // Pour que l'arrière-plan du bouton soit le même que celui du Scaffold
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: () {
                          context.go('/register');
                        },
                        child: Text(
                          "S'inscrire",
                          style: TextStyle(fontSize: 18, color: secondaryColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Petit espace en bas
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}