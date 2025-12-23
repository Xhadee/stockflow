import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/router.dart';
import '../../utils/app_colors.dart';
import '../../widgets/build_header.dart';
import '../../widgets/dashboard_widgets/kpi_card.dart';
import '../../widgets/dashboard_widgets/order_item.dart';
import '../../widgets/dashboard_widgets/stock_alert_item.dart';
import '../layout/layout.dart';


// Fournisseur pour l'index du menu sélectionné
final selectedMenuIndexProvider = StateProvider<int>((ref) => 0);

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc comme sur l'image 1
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(
                "Tableau de bord",
                "Gerez le résumé de vos ventes"),

            // KPI 1: Commandes
            const KpiCard(
              title: "Commandes du jour",
              value: "24",
              color: AppColors.kpiOrange,
              icon: Icons.shopping_cart,
              iconColor: AppColors.kpiOrangeIcon,
            ),
            const SizedBox(height: 16),

            // KPI 2: Revenus
            const KpiCard(
              title: "Revenues du jour",
              value: "150350 FCFA",
              color: AppColors.kpiGreen,
              icon: Icons.attach_money,
              iconColor: AppColors.kpiGreenIcon,
            ),
            const SizedBox(height: 16),

            // KPI 3: Stock Faible
            const KpiCard(
              title: "Stock Faible",
              value: "5",
              color: AppColors.kpiRed,
              icon: Icons.warning_amber_rounded,
              iconColor: AppColors.kpiRedIcon,
            ),
            const SizedBox(height: 24),

            // Section Alertes de Stock
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: AppColors.kpiRedIcon),
                        SizedBox(width: 8),
                        Text("Alertes de Stock", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ),
                  const StockAlertItem(name: "Clavier Mecanique"),
                  const StockAlertItem(name: "Clavier Mecanique"),
                  const StockAlertItem(name: "Clavier Mecanique"),
                  const Divider(),
                  TextButton(
                      onPressed: () => context.push('/movement-alerts'),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Consulter tous les alertes",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black87),
                            ),
                            const Icon(Icons.chevron_right, color: Colors.black54),
                          ],
                        ),
                      )),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Section Commandes Récentes
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Commandes récentes", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const OrderItem(
                    id: "CMD-003",
                    client: "Seydou Diallo",
                    date: "21/12/2025",
                    status: "En attente",
                    statusColor: AppColors.statusPendingBg,
                    statusTextColor: AppColors.statusPendingText,
                  ),
                  const OrderItem(
                    id: "CMD-002",
                    client: "Khady Ndiaye",
                    date: "20/12/2025",
                    status: "Confirmée",
                    statusColor: AppColors.statusConfirmedBg,
                    statusTextColor: AppColors.statusConfirmedText,
                  ),
                  const OrderItem(
                    id: "CMD-001",
                    client: "Lamine Thiam",
                    date: "19/12/2025",
                    status: "Livrée",
                    statusColor: AppColors.statusDeliveredBg,
                    statusTextColor: AppColors.statusDeliveredText,
                  ),
                  const Divider(),
                  TextButton(
                      onPressed: () => context.push('/orders'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Consulter les commandes",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black87),
                            ),
                            const Icon(Icons.chevron_right, color: Colors.black54),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}





