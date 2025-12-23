import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddMovementScreen extends ConsumerStatefulWidget {
  const AddMovementScreen({super.key});

  @override
  ConsumerState<AddMovementScreen> createState() => _AddMovementScreenState();
}

class _AddMovementScreenState extends ConsumerState<AddMovementScreen> {
  final _formKey = GlobalKey<FormState>();

  // États locaux du formulaire
  String _movementType = 'Entrée'; // Par défaut
  String? _selectedProductId;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Mouvement de Stock",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: _submitMovement,
            child: const Text("VALIDER",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2A85FF))),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- TYPE DE MOUVEMENT (ENTRÉE / SORTIE) ---
              const Text("Type de mouvement",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildTypeOption("Entrée", Icons.add_circle_outline, Colors.green),
                  const SizedBox(width: 12),
                  _buildTypeOption("Sortie", Icons.remove_circle_outline, Colors.red),
                ],
              ),
              const SizedBox(height: 32),

              // --- SÉLECTION DU PRODUIT ---
              const Text("Produit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: _inputDecoration(Icons.inventory_2_outlined, "Choisir un produit"),
                items: const [
                  DropdownMenuItem(value: "1", child: Text("Clavier Mécanique RGB")),
                  DropdownMenuItem(value: "2", child: Text("Souris Logitech G502")),
                  DropdownMenuItem(value: "3", child: Text("Écran 24 pouces Dell")),
                ],
                onChanged: (value) => setState(() => _selectedProductId = value),
                validator: (value) => value == null ? "Veuillez choisir un produit" : null,
              ),
              const SizedBox(height: 24),

              // --- QUANTITÉ ---
              const Text("Quantité", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(Icons.numbers, "Ex: 10"),
                validator: (value) => (value == null || value.isEmpty) ? "Champ requis" : null,
              ),
              const SizedBox(height: 24),

              // --- NOTES / MOTIF ---
              const Text("Note (Optionnel)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _noteController,
                maxLines: 3,
                decoration: _inputDecoration(Icons.edit_note, "Motif de l'entrée ou de la sortie..."),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour les boutons radio personnalisés (Entrée/Sortie)
  Widget _buildTypeOption(String label, IconData icon, Color color) {
    bool isSelected = _movementType == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _movementType = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? color : Colors.grey.shade200, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? color : Colors.grey),
              const SizedBox(width: 8),
              Text(label, style: TextStyle(
                  color: isSelected ? color : Colors.grey.shade700,
                  fontWeight: FontWeight.bold
              )),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(IconData icon, String hint) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, size: 20),
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
    );
  }

  void _submitMovement() {
    if (_formKey.currentState!.validate()) {
      // Logique Riverpod : ref.read(inventoryProvider.notifier).addMovement(...)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Mouvement enregistré : $_movementType de ${_quantityController.text} articles")),
      );
      context.pop();
    }
  }
}