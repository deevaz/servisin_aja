import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text;

    switch (status) {
      case 'Selesai':
        bg = AppColors.successTint;
        text = AppColors.success;
        break;
      case 'Dalam Pengerjaan':
        bg = AppColors.infoTint;
        text = AppColors.info;
        break;
      case 'Dijadwalkan':
        bg = AppColors.infoTint;
        text = AppColors.info;
        break;
      case 'Menunggu Konfirmasi':
      default:
        bg = AppColors.warningTint;
        text = AppColors.warning;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status,
        style: AppTypography.caption.copyWith(
          color: text,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
