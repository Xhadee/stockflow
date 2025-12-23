import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Importez votre provider selectedUser
import '../../providers/user_provider.dart';

class LogoutScreen extends ConsumerStatefulWidget {
  const LogoutScreen({super.key});

  @override
  ConsumerState<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends ConsumerState<LogoutScreen> {
  @override
  void initState() {
    super.initState();
    // On lance la procédure de déconnexion après le premier build
    Future.delayed(const Duration(seconds: 2), () {
      _handleLogout();
    });
  }

  void _handleLogout() {
    // 1. Réinitialiser l'utilisateur sélectionné (déclenche la garde GoRouter)
    // ref.read(selectedUserProvider.notifier).state = null;

    // 2. Optionnel : Réinitialiser d'autres états (entreprise, cache, etc.)
    // ref.invalidate(selectedEnterpriseProvider);

    // 3. Redirection explicite (même si la garde du router s'en chargera)
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Un indicateur visuel sympa
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2A85FF)),
            ),
            const SizedBox(height: 24),
            Text(
              "Déconnexion en cours...",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Merci de votre visite !",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}