import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import '../models/user.dart';




class LoyaltyTier {
  final String name;
  final int minXp;
  final Color color;
  final IconData icon;

  LoyaltyTier({
    required this.name,
    required this.minXp,
    required this.color,
    required this.icon,
  });
}


class LoyaltyScreen extends StatefulWidget {
  final UserModel user;
  const LoyaltyScreen({super.key, required this.user});

  @override
  State<LoyaltyScreen> createState() => _LoyaltyScreenState();
}

class _LoyaltyScreenState extends State<LoyaltyScreen> {
  late int _currentUserXp;

  final List<LoyaltyTier> tiers = [
    LoyaltyTier(name: 'Bronze', minXp: 0, color: AppColors.bronze, icon: Icons.shield),
    LoyaltyTier(name: 'Silver', minXp: 1000000, color: AppColors.silver, icon: Icons.star),
    LoyaltyTier(name: 'Gold', minXp: 5000000, color: AppColors.gold, icon: Icons.verified),
    LoyaltyTier(name: 'Platinum', minXp: 10000000, color: AppColors.platinum, icon: Icons.diamond),
  ];

  late LoyaltyTier _currentTier;
  LoyaltyTier? _nextTier;
  double _progress = 0.0;
  int _xpNeeded = 0;

  @override
  void initState() {
    super.initState();
    _currentUserXp = widget.user.spending;
    _determineTierAndProgress();
  }

  void _determineTierAndProgress() {
    _currentTier = tiers.lastWhere((tier) => _currentUserXp >= tier.minXp, orElse: () => tiers.first);
    
    int currentTierIndex = tiers.indexOf(_currentTier);
    
    if (currentTierIndex < tiers.length - 1) {
      _nextTier = tiers[currentTierIndex + 1];
      int xpForNextTier = _nextTier!.minXp - _currentTier.minXp;
      int xpInCurrentTier = _currentUserXp - _currentTier.minXp;
      _progress = xpInCurrentTier / xpForNextTier;
      _xpNeeded = _nextTier!.minXp - _currentUserXp;
    } else {
      _nextTier = null;
      _progress = 1.0;
      _xpNeeded = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text('Membership Detail', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCurrentTierHeader(),
              const SizedBox(height: 24),
              _buildTierProgressBar(),
              const SizedBox(height: 32),
              _buildAllTiersView(),
              const SizedBox(height: 32),
              _buildBenefitsSection(),
              const SizedBox(height: 24),
              _buildTermsAndConditions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentTierHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(_currentTier.icon, color: _currentTier.color, size: 50),
          const SizedBox(height: 8),
          Text(
            _currentTier.name.toUpperCase(),
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Total Spending: Rp$_currentUserXp',
            style: TextStyle(
              color: AppColors.white.withAlpha(204),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: _progress,
            minHeight: 12,
            backgroundColor: const Color(0xFF2C2C2E),
            valueColor: AlwaysStoppedAnimation<Color>(_nextTier?.color ?? _currentTier.color),
          ),
        ),
        const SizedBox(height: 8),
        if (_nextTier != null)
          Text(
            'Tambah Rp$_xpNeeded lagi jadi ${_nextTier!.name}',
            style: const TextStyle(fontSize: 14, color: AppColors.white),
          )
        else
          const Text(
            'Kamu berada di level tertinggi!',
            style: TextStyle(fontSize: 14, color: AppColors.white, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }

  Widget _buildAllTiersView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tiers.map((tier) {
        bool isActive = tier.name == _currentTier.name;
        return Expanded(child: TierCard(tier: tier, isActive: isActive));
      }).toList(),
    );
  }

  Widget _buildBenefitsSection() {
    return Card(
      elevation: 2,
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Keuntungan Grade Ini',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBenefitItem(Icons.card_giftcard, 'Poin\nReguler'),
                _buildBenefitItem(Icons.local_offer, 'Promo\nPersonal'),
                _buildBenefitItem(Icons.store, 'Promo\nMerchant'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.gold, size: 30),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: AppColors.white),
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    return Card(
      elevation: 2,
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: const Text('Baca Syarat & Ketentuan', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
        subtitle: const Text('Ketahui metode perhitungan XP & cara naik/turun Grade.', style: TextStyle(color: AppColors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.white),
        onTap: () {},
      ),
    );
  }
}


class TierCard extends StatelessWidget {
  final LoyaltyTier tier;
  final bool isActive;

  const TierCard({
    super.key,
    required this.tier,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isActive ? tier.color.withAlpha(51) : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? tier.color : AppColors.white.withAlpha(102),
              width: 2,
            ),
          ),
          child: Icon(tier.icon, color: tier.color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(tier.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white)),
        Text('Rp${tier.minXp}', style: TextStyle(fontSize: 10, color: AppColors.white.withAlpha(153))),
      ],
    );
  }
}