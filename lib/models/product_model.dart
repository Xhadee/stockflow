class Product {
  final String id;
  final String name;
  final double price;
  final int quantity; // Stock actuel
  final String sku; // Code de référence unique
  final String? description;
  final String? imageUrl; // Pour les futures évolutions

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.sku,
    this.description,
    this.imageUrl,
  });

  // Méthode simple pour la conversion en map si vous travaillez avec JSON/Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'sku': sku,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  // Méthode pour créer un objet Product à partir d'une Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? 'Produit Inconnu',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      quantity: map['quantity'] as int? ?? 0,
      sku: map['sku'] ?? 'SKU-000',
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  // Ajout de la fonction copyWith pour faciliter les mises à jour (utile dans l'écran d'édition)
  Product copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
    String? sku,
    String? description,
    String? imageUrl,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      sku: sku ?? this.sku,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}