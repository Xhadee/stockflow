import 'package:flutter/material.dart';

class AddEditWidget extends StatefulWidget {
  final String title;
  final Map<String, dynamic>? entity;
  final void Function(Map<String, dynamic>) onSave;
  final List<Map<String, dynamic>>? fields; // champs dynamiques (optionnel)

  const AddEditWidget({
    super.key,
    required this.title,
    this.entity,
    required this.onSave,
    this.fields,
  });

  @override
  State<AddEditWidget> createState() => AddEditWidgetState();
}

class AddEditWidgetState extends State<AddEditWidget> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, TextEditingController> controllers = {};

  // Palette StockFlow
  final Color primaryColor = const Color(0xFF18534F);
  final Color secondaryColor = const Color(0xFF226D68);
  final Color backgroundColor = const Color(0xFFECF8F6);
  final Color accentColor = const Color(0xFFFEEAA1);
  final Color buttonColor = const Color(0xFFD6955B);

  @override
  void initState() {
    super.initState();
    if (widget.fields != null) {
      for (var field in widget.fields!) {
        controllers[field['key']] =
            TextEditingController(text: field['initialValue']?.toString() ?? '');
      }
    }
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildField(Map<String, dynamic> field) {
    final type = field['type'] ?? 'text';
    final key = field['key'] ?? '';
    final label = field['label'] ?? '';

    if (type == 'dropdown') {
      final options = field['options'] ?? [];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: DropdownButtonFormField<String>(
          value: controllers[key]?.text.isNotEmpty == true ? controllers[key]!.text : null,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: secondaryColor.withOpacity(0.8)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
          items: options
              .map<DropdownMenuItem<String>>(
                (opt) => DropdownMenuItem(value: opt, child: Text(opt)),
          )
              .toList(),
          onChanged: (value) {
            setState(() {
              controllers[key]?.text = value ?? '';
            });
          },
          validator: (value) {
            if ((value ?? '').isEmpty) return 'Veuillez sélectionner $label';
            return null;
          },
        ),
      );
    }

    TextInputType keyboardType = TextInputType.text;
    if (type == 'email') keyboardType = TextInputType.emailAddress;
    if (type == 'number') keyboardType = TextInputType.number;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controllers[key],
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: secondaryColor.withOpacity(0.8)),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Veuillez entrer $label';
          if (type == 'email' && !value.contains('@')) return 'Email invalide';
          return null;
        },
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final data = <String, dynamic>{};
      controllers.forEach((key, controller) {
        data[key] = controller.text;
      });
      widget.onSave(data);
      Navigator.pop(context, data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (widget.fields != null)
                      ...widget.fields!.map(_buildField).toList(),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Enregistrer',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
