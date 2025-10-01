import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/data/membership_data.dart';
import 'package:project_midterms/screens/tier_info_page.dart';

import '../models/user.dart';
import '../models/membership_tier.dart';

class MembershipDetailPage extends StatefulWidget {
  final UserModel user;
  final MembershipTier? selectedTier;
  const MembershipDetailPage({super.key, required this.user, this.selectedTier});

  @override
  State<MembershipDetailPage> createState() => _MembershipDetailPageState();
}

class _MembershipDetailPageState extends State<MembershipDetailPage> {
  late double _currentUserXp;

  late MembershipTier _currentTier;
  MembershipTier? _nextTier;
  double _progress = 0.0;
  double _xpNeeded = 0.0;

  final NumberFormat f = NumberFormat.decimalPattern('id');

  @override
  void initState() {
    super.initState();
    _currentUserXp = widget.user.xp;
    _calculateTierProgress();
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
      backgroundColor: const Color(0xFF1E1E1E),
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
                    fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                  '1. XP dihitung dari total belanja Anda selama 3 bulan terakhir.\n\n' 
                  '2. Setiap pembelanjaan Rp 1.000,- akan mendapatkan 1 Poin Voucher dan 0.1 XP, poin digunakan untuk ditukarkan ke voucher, sedangkan xp untuk naik level.\n\n' 
                  '3. Kenaikan Grade terjadi secara otomatis ketika XP Anda mencapai ambang batas minimal Grade berikutnya.\n\n' 
                  '4. Penurunan Grade akan dievaluasi setiap 3 bulan. Jika total XP Anda tidak memenuhi syarat minimal Grade saat ini, maka Grade Anda akan diturunkan ke level yang sesuai.\n\n' 
                  '5. Ingat kata Timothy Ronald, Orang yang hemat hemat terus terusan itu tidak mungkin sepintar itu, dikarenakan itu merupakan aktivitas paling GOBL*K, ya paling GOBL*K karena duit ga dibawah mati apalagi, ini duit fiktif jadi teruslah berbelanja', style: TextStyle(color: AppColors.white)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: AppColors.black),
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
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text('Membership Detail'),
        backgroundColor: AppColors.black,
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
        color: const Color(0xFF1E1E1E),
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
            style: GoogleFonts.poppins(color: Colors.white.withAlpha(204)),
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
                color: Colors.white.withAlpha(77),
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

        return Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TierInfoPage(tier: tier),
                ),
              );
            },
            child: _TierCard(
                tier: tier, isCurrent: isCurrent, isSelected: false), // isSelected is always false now
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTermsSection() {
    return Card(
      elevation: 2,
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text('Baca Syarat & Ketentuan',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: AppColors.white)),
        subtitle: const Text(
            'Ketahui metode perhitungan XP & cara naik/turun Grade.', style: TextStyle(color: AppColors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.white),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Opening terms and conditions...')),
          );
          _showTermsAndConditions(context);
        },
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
                color: isSelected ? tier.color.withAlpha(51) : const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? tier.color : AppColors.white.withAlpha(102),
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
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Grade kamu',
                      style: TextStyle(color: AppColors.black, fontSize: 8)),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(tier.name,
            style:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.white)),
        Text(
          '${f.format(tier.minXp)} XP',
          style: TextStyle(fontSize: 12, color: AppColors.white.withAlpha(153)),
        ),
      ],
    );
  }
}