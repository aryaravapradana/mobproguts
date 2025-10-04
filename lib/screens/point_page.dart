import 'package:flutter/material.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:project_midterms/data/redeem_history_data.dart';
import 'package:project_midterms/data/voucher_data.dart';
import 'package:project_midterms/models/voucher.dart';

class PointPage extends StatefulWidget {
  final UserModel user;
  const PointPage({super.key, required this.user});

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  late Map<String, double> spendingByCategory;

  @override
  void initState() {
    super.initState();
    spendingByCategory = _calculateSpending();
  }

  Map<String, double> _calculateSpending() {
    final spending = <String, double>{};
    for (var redeemed in redeemedVouchers) {
      final category = _getCategoryForVoucher(redeemed);
      spending.update(category, (value) => value + redeemed.cost, ifAbsent: () => redeemed.cost.toDouble());
    }
    return spending;
  }

  String _getCategoryForVoucher(Voucher voucher) {
    for (var entry in categorizedVouchers.entries) {
      if (entry.value.any((v) => v.title == voucher.title)) {
        return entry.key;
      }
    }
    return 'Others';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Points', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPointsCard(),
            const SizedBox(height: 24),
            _buildSpendingChart(),
            const SizedBox(height: 24),
            _buildInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Points', style: GoogleFonts.poppins(color: AppColors.onPrimary, fontSize: 16)),
              Text('${widget.user.poin}', style: GoogleFonts.poppins(color: AppColors.onPrimary, fontSize: 40, fontWeight: FontWeight.bold)),
            ],
          ),
          const Icon(Icons.star, color: Colors.white, size: 50),
        ],
      ),
    );
  }

  Widget _buildSpendingChart() {
    final List<Color> chartColors = [
      AppColors.accent,
      AppColors.bronze,
      AppColors.silver,
      AppColors.gold,
      AppColors.platinum,
      AppColors.diamond,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Spending Breakdown', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        spendingByCategory.isEmpty
            ? const Center(child: Text('No spending data yet.'))
            : AspectRatio(
                aspectRatio: 1.7,
                child: PieChart(
                  PieChartData(
                    sections: List.generate(spendingByCategory.length, (i) {
                      final entry = spendingByCategory.entries.elementAt(i);
                      return PieChartSectionData(
                        color: chartColors[i % chartColors.length],
                        value: entry.value,
                        title: '${entry.key}\n(${entry.value.toInt()} pts)',
                        radius: 80,
                        titleStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                      );
                    }),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Point Information', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildInfoTile(
          icon: Icons.info_outline,
          title: 'Point Value',
          subtitle: 'Rp 1.000 = 1 Point',
        ),
        _buildInfoTile(
          icon: Icons.card_giftcard,
          title: 'How to Redeem',
          subtitle: 'Use your points to redeem exclusive vouchers on the voucher page.',
        ),
      ],
    );
  }

  Widget _buildInfoTile({required IconData icon, required String title, required String subtitle}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: GoogleFonts.poppins()),
      ),
    );
  }
}
