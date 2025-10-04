import 'package:flutter/material.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:project_midterms/data/redeem_history_data.dart';
import 'package:project_midterms/data/voucher_data.dart';
import 'package:project_midterms/models/voucher.dart';
import 'package:project_midterms/screens/category_voucher_list_page.dart';

class PointPage extends StatefulWidget {
  final UserModel user;
  const PointPage({super.key, required this.user});

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  late Map<String, double> spendingByCategory;
  int touchedIndex = -1;

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('My Points', style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Points', style: GoogleFonts.inter(color: Colors.black, fontSize: 16)),
              Text('${widget.user.poin}', style: GoogleFonts.inter(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold)),
            ],
          ),
          const Icon(Icons.star, color: Colors.white, size: 50),
        ],
      ),
    );
  }

  Widget _buildSpendingChart() {
    final totalSpent = spendingByCategory.values.fold(0.0, (sum, item) => sum + item);
    final List<Color> chartColors = [
      AppColors.fashionBlueLight,
      AppColors.fnborange,
      AppColors.travelGreenNeon,
      AppColors.primary,
      AppColors.accentGold,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Spending Breakdown', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 16),
        spendingByCategory.isEmpty
            ? const Center(child: Text('No spending data yet.', style: TextStyle(color: AppColors.textPrimary)))
            : Column(
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Stack(
                      children: [
                        PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                  if (event is FlTapUpEvent) {
                                    final category = spendingByCategory.keys.elementAt(touchedIndex);
                                    final vouchers = categorizedVouchers[category] ?? [];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CategoryVoucherListPage(category: category, vouchers: vouchers),
                                      ),
                                    );
                                  }
                                });
                              },
                            ),
                            sections: List.generate(spendingByCategory.length, (i) {
                              final isTouched = i == touchedIndex;
                              final radius = isTouched ? 60.0 : 50.0;
                              final entry = spendingByCategory.entries.elementAt(i);
                              Color color;
                              switch (entry.key) {
                                case 'Fashion':
                                  color = AppColors.fashionBlueLight;
                                  break;
                                case 'Electronics':
                                  color = AppColors.electronicPurple;
                                  break;
                                case 'F&B':
                                  color = AppColors.fnbrede;
                                  break;
                                case 'Others':
                                  color = AppColors.othersBlue;
                                  break;
                                case 'Service':
                                  color = AppColors.travelGreenNeon;
                                  break;
                                default:
                                  color = chartColors[i % chartColors.length];
                              }
                              return PieChartSectionData(
                                color: color,
                                value: entry.value,
                                title: '',
                                radius: radius,
                                borderSide: isTouched ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
                              );
                            }),
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Total Spent', style: GoogleFonts.inter(color: AppColors.textMediumGrey, fontSize: 12)),
                                                            Text('${totalSpent.toInt()} pts', style: GoogleFonts.inter(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildLegend(chartColors, totalSpent),
                ],
              ),
      ],
    );
  }

  Widget _buildLegend(List<Color> chartColors, double totalSpent) {
    return Column(
      children: List.generate(spendingByCategory.length, (i) {
        final entry = spendingByCategory.entries.elementAt(i);
        Color color;
        switch (entry.key) {
          case 'Fashion':
            color = AppColors.fashionBlueLight;
            break;
          case 'Electronics':
            color = AppColors.electronicPurple;
            break;
          case 'F&B':
            color = AppColors.fnbrede;
            break;
          case 'Others':
            color = AppColors.othersBlue;
            break;
          case 'Service':
            color = AppColors.travelGreenNeon;
            break;
          default:
            color = chartColors[i % chartColors.length];
        }
        final percentage = (entry.value / totalSpent * 100).toStringAsFixed(1);
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text('${entry.key} - ${entry.value.toInt()} pts ($percentage%)', style: const TextStyle(color: AppColors.textPrimary)),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Point Information', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 16),
        _buildInfoTile(
          icon: Icons.info,
          title: 'Point Value',
          subtitle: 'Rp 1.000 = 1 Point',
        ),
        _buildInfoTile(
          icon: Icons.redeem,
          title: 'How to Redeem',
          subtitle: 'Use your points to redeem exclusive vouchers on the voucher page.',
        ),
      ],
    );
  }

  Widget _buildInfoTile({required IconData icon, required String title, required String subtitle}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerDark,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(51),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text(subtitle, style: GoogleFonts.inter(color: AppColors.textMediumGrey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}