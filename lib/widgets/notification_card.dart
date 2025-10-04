import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/notification.dart' as model;
import 'package:simple_gradient_text/simple_gradient_text.dart';

class NotificationCard extends StatelessWidget {
  final model.Notification notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withAlpha(25)),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 6,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: notification.gradientColors ?? [AppColors.primary, AppColors.primaryDark],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: AppColors.iconBgDark,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.white.withAlpha(25)),
                              ),
                              child: Icon(notification.icon, color: AppColors.primary, size: 30),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GradientText(
                                notification.title,
                                colors: notification.gradientColors ?? [AppColors.primary, AppColors.primaryDark],
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(notification.subtitle, style: const TextStyle(color: AppColors.textMutedDark, fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (notification.progress != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (notification.tag != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: notification.tagColor?.withAlpha(51) ?? AppColors.primary.withAlpha(51),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      notification.tag!,
                                      style: TextStyle(color: notification.tagColor ?? AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: notification.progress!,
                              backgroundColor: Colors.grey.withAlpha(77),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                notification.gradientColors?[0] ?? AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (notification.buttonText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(notification.buttonText!, style: const TextStyle(color: AppColors.primary)),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}