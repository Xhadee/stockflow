// La liste de toutes les entreprises de l'utilisateur
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/entreprise_model.dart';

final enterprisesProvider = Provider<List<EnterpriseModel>>((ref) {
  return [
    EnterpriseModel(id: '1', name: "Seydou's Shop", logo: "S"),
    EnterpriseModel(id: '2', name: "Malick Electronics", logo: "M"),
  ];
});

// L'entreprise actuellement sélectionnée (par défaut la première)
final selectedEnterpriseProvider = StateProvider<EnterpriseModel>((ref) {
  return ref.watch(enterprisesProvider).first;
});