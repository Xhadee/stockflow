import 'package:flutter/material.dart';
import 'package:stockflow/screens/auth/home_screen.dart';
import 'package:stockflow/screens/auth/welcome_screen.dart';
import 'package:stockflow/screens/customer/customer_detail_screen.dart';
import 'package:stockflow/screens/customer/customer_list_screen.dart';
import 'package:stockflow/screens/dashboard/dashboard_screen.dart';
import 'package:stockflow/screens/inventory/movement_list_screen.dart';
import 'package:stockflow/screens/order/add_edit_order_screen.dart';
import 'package:stockflow/screens/organization/add_edit_organization_screen.dart';
import 'package:stockflow/widgets/movement_card.dart';
import 'screens/auth//login_screen.dart';
import 'package:stockflow/screens/products/product_list_screen.dart';
import 'package:stockflow/screens/order/order_list_screen.dart';
import 'package:stockflow/screens/organization/organization_list_screen.dart';
import 'package:stockflow/screens/settings/settings_screen.dart';

void main() {
  runApp(const StockFlowApp());
}

class StockFlowApp extends StatelessWidget {
  const StockFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StockFlow',
      theme: ThemeData(useMaterial3: true),
      home:  DashboardScreen(),
    );
  }
}
