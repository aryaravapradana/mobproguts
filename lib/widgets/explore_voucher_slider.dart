
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';

class PromoItem {
  final String title;
  final String subtitle;
  final String imageUrl;

  PromoItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

class ExploreVoucherSlider extends StatefulWidget {
  const ExploreVoucherSlider({super.key});

  @override
  State<ExploreVoucherSlider> createState() => _ExploreVoucherSliderState();
}

class _ExploreVoucherSliderState extends State<ExploreVoucherSlider> {
  final PageController _controller = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  

  final List<PromoItem> promos = [
    PromoItem(
      title: "Special Offer For You!",
      subtitle: "Get 20% off on your next purchase.",
      imageUrl: "assets/images/promo_fashion.png",
    ),
    PromoItem(
      title: "Weekend Promo!",
      subtitle: "Free parking 2 jam di mall pilihan.",
      imageUrl: "assets/images/promo_movie.png",
    ),
    PromoItem(
      title: "Cashback Bonus!",
      subtitle: "Top up dapat cashback 10%.",
      imageUrl: "assets/images/promo_coffee.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _controller,
            itemCount: promos.length,
            itemBuilder: (context, index) {
              final promo = promos[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(promo.imageUrl, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                                                            Colors.black.withAlpha((255 * 0.8).round()),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      // Lapis 3: Teks
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              promo.title,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.onBackground,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              promo.subtitle,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(promos.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? AppColors.primary
                    : AppColors.darkGrey,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
