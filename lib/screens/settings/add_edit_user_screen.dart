import 'package:flutter/material.dart';
import 'package:stockflow/widgets/add_edit_widget.dart';

class AddEditUserScreen extends StatelessWidget {
  static const String routeName = '/add-edit-user';

  final Map<String, dynamic>? user;

  const AddEditUserScreen({super.key, this.user});

  // Palette StockFlow
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  @override
  Widget build(BuildContext context) {
    return AddEditWidget(
      title: user == null ? 'Ajouter utilisateur' : 'Modifier utilisateur',
      entity: user,
      onSave: (data) {
        print('Utilisateur sauvegardé: $data');
      },
      fields: [
        {
          'label': 'Nom',
          'key': 'name',
          'type': 'text',
          'initialValue': user?['name'] ?? '',
        },
        {
          'label': 'Email',
          'key': 'email',
          'type': 'email',
          'initialValue': user?['email'] ?? '',
        },
        {
          'label': 'Téléphone',
          'key': 'phone',
          'type': 'text',
          'initialValue': user?['phone'] ?? '',
        },
        {
          'label': 'Rôle',
          'key': 'role',
          'type': 'dropdown',
          'options': ['Admin', 'Utilisateur'],
          'initialValue': user?['role'] ?? 'Utilisateur',
        },
      ],
    );
  }
}
