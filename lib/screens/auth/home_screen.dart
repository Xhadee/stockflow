import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'welcome_screen.dart';
// Importez les autres écrans de l'application si vous prévoyez d'y naviguer depuis le tableau de bord
// import 'products_screen.dart';
// import 'orders_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  // Palette de couleurs
  final Color primaryColor = const Color(0xFF18534F); // Vert foncé principal (pour l'AppBar, boutons principaux)
  final Color secondaryColor = const Color(0xFF226D68); // Vert moyen/foncé
  final Color backgroundColor = const Color(0xFFECF8F6); // Arrière-plan très clair
  final Color accentColor = const Color(0xFFFEEAA1); // Jaune/Crème
  final Color buttonColor = const Color(0xFFD6955B); // Orange/Brun (pour les actions clés)

  // Couleurs pour les cartes du Dashboard (personnalisées pour un meilleur contraste)
  final Color cardColor1 = const Color(0xFF226D68); // Secondary Color
  final Color cardColor2 = const Color(0xFFD6955B); // Button Color
  final Color cardColor3 = const Color(0xFF18534F); // Primary Color
  final Color cardColor4 = Colors.red.shade400; // Couleur d'alerte

  // Widget de construction d'une carte de tableau de bord
  Widget _buildDashboardCard(BuildContext context, String title, String value, IconData icon, Color color, {VoidCallback? onTap}) {
    return InkWell( // Utilisation d'InkWell pour rendre la carte cliquable avec un effet visuel
      onTap: onTap,
      borderRadius: BorderRadius.circular(20), // Bords très arrondis
      child: Card(
        // Retirer l'ombre de la Card et la mettre dans le Container pour un meilleur contrôle
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              const Spacer(),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 32, // Taille plus grande pour la valeur
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // Utilisation d'un Drawer pour le menu latéral (navigation vers d'autres pages)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.inventory_2, color: accentColor, size: 40),
                  SizedBox(height: 8),
                  Text('StockFlow Menu', style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: secondaryColor),
              title: Text('Tableau de bord'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.inventory, color: secondaryColor),
              title: Text('Gestion des produits'),
              onTap: () {
                // Naviguer vers ProductsScreen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart_sharp, color: secondaryColor),
              title: Text('Gestion des commandes'),
              onTap: () {
                // Naviguer vers OrdersScreen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: secondaryColor),
              title: Text('Paramètres'),
              onTap: () {
                // Naviguer vers SettingsScreen
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.redAccent),
              title: Text('Déconnexion'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text('Tableau de bord StockFlow', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 4, // Ombre subtile sous l'AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Déconnexion',
            onPressed: () {
              // Naviguer vers l'écran de connexion et supprimer toutes les routes précédentes
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section Bienvenue ---
            Text(
              'Bonjour, [Nom de l\'utilisateur] !',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Voici un aperçu rapide de l'état de votre stock :",
              style: TextStyle(
                fontSize: 16,
                color: secondaryColor.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 30),

            // --- GridView pour les Indicateurs Clés (KPIs) ---
            GridView.count(
              shrinkWrap: true, // Nécessaire car nous sommes dans un SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(), // Désactive le défilement du GridView
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1, // Ajuster le ratio pour que les cartes soient légèrement plus larges
              children: [
                _buildDashboardCard(
                    context,
                    'Produits uniques',
                    '120',
                    Icons.inventory_2_rounded,
                    cardColor3, // Primary Color
                    onTap: () {
                      // Action: Naviguer vers la gestion des produits
                    }
                ),
                _buildDashboardCard(
                    context,
                    'Commandes en attente',
                    '45',
                    Icons.receipt_long_rounded,
                    cardColor2, // Button Color (Orange)
                    onTap: () {
                      // Action: Naviguer vers la gestion des commandes
                    }
                ),
                _buildDashboardCard(
                    context,
                    'Alertes Stock Bas',
                    '5',
                    Icons.notification_important_rounded,
                    cardColor4, // Red
                    onTap: () {
                      // Action: Naviguer vers les alertes
                    }
                ),
                _buildDashboardCard(
                    context,
                    'Total Clients',
                    '30',
                    Icons.people_alt_rounded,
                    cardColor1, // Secondary Color
                    onTap: () {
                      // Action: Naviguer vers la gestion des clients
                    }
                ),
              ],
            ),
            const SizedBox(height: 40),

            // --- Section d'Action Rapide / Graphique ---
            Text(
              'Statistiques journalières',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 15),

            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Zone de graphique ou de statistiques récentes (Ex. : Ventes du jour)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: secondaryColor.withOpacity(0.6)),
                ),
              ), // Ici vous insérerez votre graphique ou liste d'actions
            ),
          ],
        ),
      ),
    );
  }
}