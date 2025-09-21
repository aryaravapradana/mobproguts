import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/user.dart';
import '../models/membership_tier.dart';

class MembershipDetailPage extends StatefulWidget {
  const MembershipDetailPage({super.key});

  @override
  State<MembershipDetailPage> createState() => _MembershipDetailPageState();
}

class _MembershipDetailPageState extends State<MembershipDetailPage> {
  final double _currentUserXp = currentUser.xp;

  final List<MembershipTier> tiers = [
    MembershipTier(
      name: 'Bronze',
      minXp: 0,
      icon: Icons.shield_outlined,
      color: const Color(0xFFCD7F32),
      perks: [
        Perk(name: "Poin Reguler", icon: Icons.monetization_on),
      ],
    ),
    MembershipTier(
      name: 'Silver',
      minXp: 300,
      icon: Icons.star_border,
      color: const Color(0xFFC0C0C0),
      perks: [
        Perk(name: "Poin Reguler", icon: Icons.monetization_on),
        Perk(name: "Promo Personal", icon: Icons.local_offer),
      ],
    ),
    MembershipTier(
      name: 'Gold',
      minXp: 800,
      icon: Icons.star,
      color: const Color(0xFFFFD700),
      perks: [
        Perk(name: "Poin Reguler", icon: Icons.monetization_on),
        Perk(name: "Promo Personal", icon: Icons.local_offer),
        Perk(name: "Promo Merchant", icon: Icons.storefront),
      ],
    ),
    MembershipTier(
      name: 'Platinum',
      minXp: 1100,
      icon: Icons.verified_outlined,
      color: const Color(0xFFE5E4E2),
      perks: [
        Perk(name: "Poin Reguler", icon: Icons.monetization_on),
        Perk(name: "Promo Personal", icon: Icons.local_offer),
        Perk(name: "Promo Merchant", icon: Icons.storefront),
      ],
    ),
    MembershipTier(
      name: 'Diamond',
      minXp: 1500,
      icon: Icons.diamond_outlined,
      color: const Color(0xFFB9F2FF),
      perks: [
        Perk(name: "Poin Reguler", icon: Icons.monetization_on),
        Perk(name: "Promo Personal", icon: Icons.local_offer),
        Perk(name: "Promo Merchant", icon: Icons.storefront),
      ],
    ),
  ];

  late MembershipTier _selectedTier;
  late MembershipTier _currentTier;
  MembershipTier? _nextTier;
  double _progress = 0.0;
  double _xpNeeded = 0.0;

  final NumberFormat f = NumberFormat.decimalPattern('id');

  @override
  void initState() {
    super.initState();
    _calculateTierProgress();
    _selectedTier = _currentTier;
  }

  void _selectTier(MembershipTier tier) {
    setState(() {
      _selectedTier = tier;
    });
  }

  void _calculateTierProgress() {
    _currentTier = tiers
        .lastWhere((tier) => _currentUserXp >= tier.minXp, orElse: () => tiers.first);

    int currentTierIndex = tiers.indexOf(_currentTier);

    if (currentTierIndex < tiers.length - 1) {
      _nextTier = tiers[currentTierIndex + 1];
      double xpForNextTier = (_nextTier!.minXp - _currentTier.minXp).toDouble();
      double xpInCurrentTier = _currentUserXp - _currentTier.minXp;
      _progress = (xpForNextTier > 0) ? (xpInCurrentTier / xpForNextTier) : 1.0;
      _xpNeeded = _nextTier!.minXp - _currentUserXp;
    } else {
      _nextTier = null;
      _progress = 1.0;
      _xpNeeded = 0.0;
    }
  }

  void _showTermsAndConditions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Syarat & Ketentuan',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                  '1. XP dihitung dari total belanja Anda selama 3 bulan terakhir.\n\n'
                  '2. Setiap pembelanjaan Rp 1.000,- akan mendapatkan 1 Poin Voucher dan 0.1 XP, poin digunakan untuk ditukarkan ke voucher, sedangkan xp untuk naik level.\n\n'
                  '3. Kenaikan Grade terjadi secara otomatis ketika XP Anda mencapai ambang batas minimal Grade berikutnya.\n\n'
                  '4. Penurunan Grade akan dievaluasi setiap 3 bulan. Jika total XP Anda tidak memenuhi syarat minimal Grade saat ini, maka Grade Anda akan diturunkan ke level yang sesuai.\n\n'
                  '5. Ingat kata Timothy Ronald, Orang yang hemat hemat terus terusan itu tidak mungkin sepintar itu, dikarenakan itu merupakan aktivitas paling GOBL*K, ya paling GOBL*K karena duit ga dibawah mati apalagi, ini duit fiktif jadi teruslah berbelanja'),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Mengerti'),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('Membership Detail'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildTierCards(),
            const SizedBox(height: 24),
            _buildPerksSection(),
            const SizedBox(height: 16),
            _buildTermsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF6A5ACD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(_currentTier.icon, color: _currentTier.color, size: 50),
          const SizedBox(height: 8),
          Text(
            _currentTier.name,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Total XP: ${_currentUserXp.toStringAsFixed(1)} XP',
            style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8)),
          ),
          const SizedBox(height: 20),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        if (_nextTier != null)
          Text(
            'Tambah ${_xpNeeded.toStringAsFixed(1)} XP lagi jadi ${_nextTier!.name}',
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600),
          )
        else
          Text(
            'Kamu berada di level tertinggi!',
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              widthFactor: _progress,
              child: Container(
                height: 12,
                decoration: BoxDecoration(
                  color: _currentTier.color,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTierCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tiers.map((tier) {
        bool isCurrent = tier.name == _currentTier.name;
        bool isSelected = tier.name == _selectedTier.name;

        return Expanded(
          child: GestureDetector(
            onTap: () => _selectTier(tier),
            child: _TierCard(
                tier: tier, isCurrent: isCurrent, isSelected: isSelected),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPerksSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Keuntungan Grade ${_selectedTier.name}',
              style:
                  GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _selectedTier.perks.map((perk) {
                return Column(
                  children: [
                    Icon(perk.icon, color: Colors.deepPurple, size: 30),
                    const SizedBox(height: 8),
                    Text(perk.name, textAlign: TextAlign.center),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text('Baca Syarat & Ketentuan',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        subtitle: const Text(
            'Ketahui metode perhitungan XP & cara naik/turun Grade.'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _showTermsAndConditions(context),
      ),
    );
  }
}

class _TierCard extends StatelessWidget {
  final MembershipTier tier;
  final bool isCurrent;
  final bool isSelected;

  const _TierCard(
      {required this.tier, required this.isCurrent, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.decimalPattern('id');
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? tier.color.withOpacity(0.2) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? tier.color : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: Icon(tier.icon, color: tier.color, size: 30),
            ),
            if (isCurrent)
              Positioned(
                top: -10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Grade kamu',
                      style: TextStyle(color: Colors.white, fontSize: 8)),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(tier.name,
            style:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
        Text(
          '${f.format(tier.minXp)} XP',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }
}