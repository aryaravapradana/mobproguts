import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/data/membership_data.dart';
import 'package:project_midterms/data/voucher_data.dart';
import 'package:project_midterms/models/voucher.dart';
import 'package:project_midterms/screens/my_vouchers_page.dart';
import '../models/user.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/screens/voucher_detail_page.dart';
import 'package:project_midterms/widgets/animated_hover_card.dart';
import 'package:project_midterms/widgets/voucher_cost_display.dart';

class VoucherPage extends StatefulWidget {
  final UserModel user;
  const VoucherPage({super.key, required this.user});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  int _getTierRank(String tierName) {
    return tiers.indexWhere((tier) => tier.name == tierName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vouchers',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyVouchersPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(child: _buildVoucherGrid()),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search vouchers...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.lightGrey.withAlpha(50),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['All', ...categorizedVouchers.keys].map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: FilterChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: _selectedCategory == category
                          ? Colors.white
                          : AppColors.onSurface,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherGrid() {
    final userTierRank = _getTierRank(widget.user.level);
    List<Voucher> filteredVouchers = dummyVouchers.where((voucher) {
      // Tier check
      final requiredTierRank = voucher.requiredTier != null
          ? _getTierRank(voucher.requiredTier!)
          : -1;
      final isTierSufficient =
          voucher.requiredTier == null || userTierRank >= requiredTierRank;

      if (!isTierSufficient) {
        return false;
      }

      final titleMatches = voucher.title.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final categoryMatches =
          _selectedCategory == 'All' ||
          categorizedVouchers.entries
              .firstWhere((entry) => entry.key == _selectedCategory)
              .value
              .contains(voucher);

      return titleMatches && categoryMatches;
    }).toList();

    if (filteredVouchers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 60, color: AppColors.lightGrey),
            const SizedBox(height: 16),
            Text(
              "No vouchers found",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: filteredVouchers.length,
      itemBuilder: (context, index) {
        final voucher = filteredVouchers[index];
        final bool isExclusive = voucher.requiredTier != null;
        final tierColor = isExclusive
            ? tiers.firstWhere((t) => t.name == voucher.requiredTier).color
            : Colors.transparent;
        return AnimatedHoverCard(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    VoucherDetailPage(voucher: voucher, user: widget.user),
              ),
            );

            if (result == true) {
              setState(() {});
            }
          },
          child: Stack(
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: isExclusive ? BorderSide(color: tierColor, width: 2) : BorderSide.none,
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.asset(
                        voucher.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: AppColors.lightGrey,
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            voucher.title,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          VoucherCostDisplay(voucher: voucher, user: widget.user, fontSize: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (isExclusive)
                Positioned(
                  top: 8,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: tierColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((255 * 0.3).round()),
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      '${voucher.requiredTier} Tier',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ).animate().fadeIn(duration: 300.ms, delay: (50 * index).ms);
      },
    );
  }
}