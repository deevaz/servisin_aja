import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons_plus/ionicons_plus.dart';
import '../../core/theme/app_colors.dart';

class SnackbarUtil {
  static void _showBottomSheet({
    required String title,
    required String message,
    required IconData icon,
    required Color accentColor,
    String buttonText = 'Tutup',
    VoidCallback? onTap,
  }) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accentColor, size: 36),
            ),
            const SizedBox(height: 16),

            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: AppColors.surface,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Get.back();
                  onTap?.call();
                },
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  static void success(String title, String message) {
    _showBottomSheet(
      title: title,
      message: message,
      icon: Ionicons.checkmark_circle,
      accentColor: AppColors.primary,
    );
  }

  static void error(String title, String message) {
    _showBottomSheet(
      title: title,
      message: message,
      icon: Ionicons.close_circle,
      accentColor: AppColors.info,
    );
  }

  static void warning(String title, String message) {
    _showBottomSheet(
      title: title,
      message: message,
      icon: Ionicons.warning,
      accentColor: AppColors.warning,
    );
  }

  static void info(String title, String message) {
    _showBottomSheet(
      title: title,
      message: message,
      icon: Ionicons.information_circle,
      accentColor: AppColors.info,
    );
  }

  static void notification(
    String title,
    String message, {
    VoidCallback? onTap,
  }) {
    _showBottomSheet(
      title: title,
      message: message,
      icon: Ionicons.notifications,
      accentColor: AppColors.primary,
      buttonText: 'Lihat Detail',
      onTap: onTap,
    );
  }
}
