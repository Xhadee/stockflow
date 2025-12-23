

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:stockflow/models/user_model.dart';

final userProvider = Provider<List<UserModel>>((ref) {
  return [
    UserModel(id: '1', name: "Seydou Diallo", email: "admin@seydoushop.com", password: "password123", avatar: "S"),
    UserModel(id: '2', name: "Khady Ndiaye", email: "khady@email.com", password: "password123", avatar: "K"),
    UserModel(id: '3', name: "Lamine Thiam", email: "lamine@email.com", password: "password123", avatar: "L"),
  ];
});

// L'utilisateur actuellement sélectionnée (par défaut la première)
var selectedUserProvider = StateProvider<UserModel>((ref) {
  return ref.watch(userProvider).first;
});