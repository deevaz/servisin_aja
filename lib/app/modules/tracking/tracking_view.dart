import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';
import '../../core/widgets/status_chip.dart';
import '../../core/widgets/empty_state.dart';
import 'tracking_controller.dart';

class TrackingView extends GetView<TrackingController> {
  const TrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Lacak Status Servis'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final b = controller.booking.value;
        if (b == null) {
          return const EmptyStateWidget(
            title: 'Tidak Ada Servis Aktif',
            description: 'Belum ada transaksi servis yang sedang diproses.',
          );
        }

        return Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenHorizontalPadding,
                  ),
                  itemCount: b.items.length,
                  itemBuilder: (context, index) {
                    final item = b.items[index];
                    return Obx(() {
                      final isSelected =
                          controller.selectedVehicleIndex.value == index;
                      return Container(
                        margin: const EdgeInsets.only(right: AppSpacing.sm),
                        child: ChoiceChip(
                          label: Text(
                            '${item.vehicle.name} (${item.vehicle.plateNumber})',
                          ),
                          selected: isSelected,
                          onSelected: (_) => controller.selectVehicleTab(index),
                          selectedColor: AppColors.primaryTint,
                          backgroundColor: AppColors.surface,
                          labelStyle: AppTypography.titleMedium.copyWith(
                            fontSize: 13,
                            color: isSelected
                                ? AppColors.primaryDark
                                : AppColors.textSecondary,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                            side: BorderSide(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.border,
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(
                  AppSpacing.screenHorizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    Obx(() {
                      final currentItem =
                          b.items[controller.selectedVehicleIndex.value];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(
                                AppSpacing.cardRadius,
                              ),
                              boxShadow: AppSpacing.cardShadow,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryTint,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.two_wheeler,
                                    color: AppColors.primary,
                                    size: 26,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentItem.vehicle.name,
                                        style: AppTypography.titleMedium,
                                      ),
                                      Text(
                                        'Tipe: ${currentItem.serviceType?.name}',
                                        style: AppTypography.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                StatusChip(status: currentItem.status),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),

                          Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(
                                AppSpacing.cardRadius,
                              ),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: AppColors.primaryTint,
                                  child: Icon(
                                    Icons.engineering,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mekanik Penanggung Jawab',
                                        style: AppTypography.caption,
                                      ),
                                      Text(
                                        b.mechanicName,
                                        style: AppTypography.titleMedium
                                            .copyWith(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),

                          Text(
                            'Progres Servis Unit Ini',
                            style: AppTypography.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          _buildTimeline(currentItem.status),
                        ],
                      );
                    }),
                    const SizedBox(height: AppSpacing.xxxl),
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(AppSpacing.screenHorizontalPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        label: 'Lihat Invoice',
                        icon: Icons.receipt_long,
                        onPressed: controller.goToInvoice,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: PrimaryButton(
                        label: 'Beri Ulasan',
                        icon: Icons.star_rate,
                        onPressed: controller.goToRating,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTimeline(String currentStatus) {
    final steps = [
      {
        'title': 'Menunggu Konfirmasi',
        'desc': 'Pesanan diterima & diverifikasi bengkel',
      },
      {'title': 'Dijadwalkan', 'desc': 'Nomor antrean PIT servis teralokasi'},
      {
        'title': 'Dalam Pengerjaan',
        'desc': 'Mekanik sedang mengerjakan penggantian part & tune up',
      },
      {
        'title': 'Selesai',
        'desc': 'Servis rampung, motor siap diambil & diuji coba',
      },
    ];

    int currentStepIndex = 0;
    if (currentStatus == 'Dijadwalkan') currentStepIndex = 1;
    if (currentStatus == 'Dalam Pengerjaan') currentStepIndex = 2;
    if (currentStatus == 'Selesai') currentStepIndex = 3;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: AppSpacing.cardShadow,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: List.generate(steps.length, (index) {
          final step = steps[index];
          final isCompleted = index <= currentStepIndex;
          final isCurrent = index == currentStepIndex;
          final isLast = index == steps.length - 1;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColors.primary
                            : AppColors.surface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isCompleted
                              ? AppColors.primary
                              : AppColors.border,
                          width: 2,
                        ),
                      ),
                      child: isCompleted
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : Center(
                              child: Text(
                                '${index + 1}',
                                style: AppTypography.caption.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: index < currentStepIndex
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['title']!,
                          style: AppTypography.titleMedium.copyWith(
                            fontSize: 15,
                            color: isCurrent
                                ? AppColors.primary
                                : isCompleted
                                ? AppColors.textPrimary
                                : AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(step['desc']!, style: AppTypography.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
