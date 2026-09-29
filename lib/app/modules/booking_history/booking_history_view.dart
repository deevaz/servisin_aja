import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/status_chip.dart';
import '../../core/utils/formatters.dart';
import 'booking_history_controller.dart';

class BookingHistoryView extends GetView<BookingHistoryController> {
  const BookingHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Riwayat Booking'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final list = controller.allBookings;
        if (list.isEmpty) {
          return const EmptyStateWidget(
            title: 'Belum Ada Riwayat',
            description: 'Transaksi booking servis Anda akan tampil di halaman ini.',
          );
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.screenHorizontalPadding),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final b = list[index];
            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.lg),
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                boxShadow: AppSpacing.cardShadow,
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        b.code,
                        style: AppTypography.titleMedium.copyWith(fontSize: 14),
                      ),
                      StatusChip(status: b.overallStatus),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    b.workshop.name,
                    style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                  ),
                  Text(
                    '${Formatters.formatDate(b.scheduledDate)} • Jam ${b.scheduledTime} WIB',
                    style: AppTypography.caption,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Divider(color: AppColors.border),
                  const SizedBox(height: AppSpacing.sm),

                  Text('Unit Motor (${b.items.length}):', style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  ...b.items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('• ${item.vehicle.name} (${item.vehicle.plateNumber})', style: AppTypography.bodyMedium),
                          Text(item.serviceType?.name ?? '', style: AppTypography.caption),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Biaya', style: AppTypography.caption),
                          Text(
                            Formatters.rupiah(b.totalCost),
                            style: AppTypography.titleMedium.copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () => controller.goToInvoice(b),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.border),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              minimumSize: const Size(0, 36),
                            ),
                            child: const Text('Invoice', style: TextStyle(color: AppColors.textPrimary, fontSize: 12)),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => controller.goToTracking(b),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              minimumSize: const Size(0, 36),
                            ),
                            child: const Text('Lacak Status', style: TextStyle(color: Colors.white, fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
