import 'package:flutter/material.dart';

class AddEditOrderScreen extends StatefulWidget {
  static const String routeName = '/add-edit-order';

  final Map<String, dynamic>? order; // null si création

  const AddEditOrderScreen({super.key, this.order});

  @override
  State<AddEditOrderScreen> createState() => _AddEditOrderScreenState();
}

class _AddEditOrderScreenState extends State<AddEditOrderScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _quantityController = TextEditingController();

  // Palette StockFlow
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  String _selectedClient = 'Client A';
  String _selectedProduct = 'Produit A';
  int _quantity = 1;

  // Données mock
  final List<String> _clients = ['Client A', 'Client B', 'Client C'];
  final List<String> _products = ['Produit A', 'Produit B', 'Produit C'];

  int _calculateTotal() {
    // Mock : 10€ par unité
    return _quantity * 10;
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: secondaryColor),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.order != null) {
      _selectedClient = widget.order!['client'];
      _selectedProduct = widget.order!['product'];
      _quantity = widget.order!['quantity'];
      _quantityController.text = _quantity.toString();
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(widget.order == null ? 'Nouvelle commande' : 'Modifier commande'),
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Décoration
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.35),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Client
                    DropdownButtonFormField<String>(
                      value: _selectedClient,
                      decoration: _inputDecoration('Client', Icons.person),
                      items: _clients
                          .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedClient = val);
                      },
                    ),
                    const SizedBox(height: 20),

                    // Produit
                    DropdownButtonFormField<String>(
                      value: _selectedProduct,
                      decoration: _inputDecoration('Produit', Icons.inventory_2),
                      items: _products
                          .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedProduct = val);
                      },
                    ),
                    const SizedBox(height: 20),

                    // Quantité
                    TextFormField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration('Quantité', Icons.confirmation_num),
                      onChanged: (val) {
                        setState(() {
                          _quantity = int.tryParse(val) ?? 1;
                        });
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Veuillez entrer une quantité';
                        if (int.tryParse(val) == null) return 'Quantité invalide';
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // Total
                    Text(
                      'Total : ${_calculateTotal()} €',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // Bouton Enregistrer
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: Sauvegarder via BLoC / Firestore
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Enregistrer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
