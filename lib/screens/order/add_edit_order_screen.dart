import 'package:flutter/material.dart';

class AddEditOrderScreen extends StatefulWidget {
  // Le paramètre 'order' est optionnel. S'il est fourni, c'est une modification.
  final Map<String, dynamic>? order;

  const AddEditOrderScreen({this.order, super.key});

  @override
  _AddEditOrderScreenState createState() => _AddEditOrderScreenState();
}

class _AddEditOrderScreenState extends State<AddEditOrderScreen> {
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs et variables d'état
  late TextEditingController _customerController;
  late TextEditingController _numberController;
  late String _selectedStatus;

  // Liste des statuts possibles
  final List<String> _statuses = ['Brouillon', 'Confirmée', 'En préparation', 'Expédiée', 'Annulée'];

  // Palette de couleurs
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color buttonColor = const Color(0xFFD6955B);

  bool get isEditing => widget.order != null;

  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs avec les données existantes si en mode édition
    _customerController = TextEditingController(text: widget.order?['customer'] ?? '');
    _numberController = TextEditingController(text: widget.order?['number'] ?? 'ORD-${DateTime.now().millisecondsSinceEpoch}');
    _selectedStatus = widget.order?['status'] ?? 'Brouillon';
  }

  @override
  void dispose() {
    _customerController.dispose();
    _numberController.dispose();
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

  void _saveOrder() {
    if (_formKey.currentState!.validate()) {
      // Logique de sauvegarde/mise à jour
      final String action = isEditing ? 'mise à jour' : 'créée';

      // Simulation de l'objet Order complet
      final Map<String, dynamic> newOrder = {
        'number': _numberController.text,
        'customer': _customerController.text,
        'status': _selectedStatus,
        'id': widget.order?['id'] ?? UniqueKey().toString(),
        'total': widget.order?['total'] ?? 0.0,
      };

      // Feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Commande #${newOrder['number']} $action avec succès.'),
          backgroundColor: secondaryColor,
        ),
      );
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
        title: Text(isEditing ? 'Modifier Commande' : 'Créer Nouvelle Commande', style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Champ Numéro de Commande ---
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  controller: _numberController,
                  decoration: _inputDecoration('Numéro de Commande', Icons.confirmation_number),
                  readOnly: true, // Souvent généré automatiquement
                ),
              ),

              // --- Champ Client ---
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  controller: _customerController,
                  decoration: _inputDecoration('Nom du Client', Icons.person),
                  validator: (value) => value == null || value.isEmpty ? 'Le nom du client est requis' : null,
                ),
              ),

              // --- Sélecteur de Statut ---
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.1), blurRadius: 10)],
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Statut de la Commande',
                    prefixIcon: Icon(Icons.check_circle_outline, color: Color(0xFF226D68)),
                    border: InputBorder.none,
                  ),
                  items: _statuses.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedStatus = newValue!;
                    });
                  },
                ),
              ),

              // --- Section Articles (Simulation) ---
              const SizedBox(height: 10),
              Text('Articles (Ajout/Modification nécessite une section dédiée)', style: TextStyle(color: secondaryColor)),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 30),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: secondaryColor.withOpacity(0.2)),
                ),
                child: Center(
                  child: Text('Liste des articles commandés', style: TextStyle(color: buttonColor)),
                ),
              ),


              // --- Bouton de sauvegarde ---
              ElevatedButton(
                onPressed: _saveOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: Text(
                  isEditing ? 'Sauvegarder la Commande' : 'Créer la Commande',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}