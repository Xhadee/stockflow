import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardProvider = Provider((ref) {
  return {
    'ordersToday': 24,
    'revenueToday': 150350,
    'lowStockCount': 5,
    'alerts': [
      {
        'name': 'Clavier Mecanique',
        'stock': 5,
      },
      {
        'name': 'Souris Gaming',
        'stock': 3,
      },
      {
        'name': 'Casque Audio',
        'stock': 2,
      },
    ],
    'recentOrders': [
      {
        'code': 'CMD-003',
        'client': 'Seydou Diallo',
        'date': '21/12/2025',
        'status': 'En attente',
      },
      {
        'code': 'CMD-002',
        'client': 'Khady Ndiaye',
        'date': '20/12/2025',
        'status': 'Confirmée',
      },
      {
        'code': 'CMD-001',
        'client': 'Lamine Thiam',
        'date': '19/12/2025',
        'status': 'Livrée',
      },
    ],
  };
});
