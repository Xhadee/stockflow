import 'package:flutter/material.dart';
import 'package:stockflow/widgets/add_edit_widget.dart';

class AddEditSupplierScreen extends StatelessWidget {
  static const String routeName = '/add-edit-supplier';

  final Map<String, dynamic>? supplier;

  const AddEditSupplierScreen({super.key, this.supplier});

  @override
  Widget build(BuildContext context) {
    return AddEditWidget(
      title: supplier == null ? 'Ajouter fournisseur' : 'Modifier fournisseur',
      entity: supplier,
      onSave: (data) {
        print('Fournisseur sauvegardé : $data');
      },
      fields: [
        {
          'label': 'Nom',
          'key': 'name',
          'type': 'text',
          'initialValue': supplier?['name'] ?? '',
        },
        {
          'label': 'Email',
          'key': 'email',
          'type': 'email',
          'initialValue': supplier?['email'] ?? '',
        },
        {
          'label': 'Téléphone',
          'key': 'phone',
          'type': 'text',
          'initialValue': supplier?['phone'] ?? '',
        },
        {
          'label': 'Adresse',
          'key': 'address',
          'type': 'text',
          'initialValue': supplier?['address'] ?? '',
        },
        {
          'label': 'Statut',
          'key': 'status',
          'type': 'dropdown',
          'options': ['Actif', 'Inactif'],
          'initialValue': supplier?['status'] ?? 'Actif',
        },
      ],
    );
  }
}
