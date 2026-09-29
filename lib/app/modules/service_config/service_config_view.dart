import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/service_card.dart';
import '../../core/utils/formatters.dart';
import 'service_config_controller.dart';

class ServiceConfigView extends GetView<ServiceConfigController> {
  const ServiceConfigView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Atur Paket Servis'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(
                  AppSpacing.screenHorizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.primaryTint,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.build_outlined,
                            color: AppColors.primary,
                            size: 22,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              'Atur jenis servis, paket oli, & keluhan untuk tiap motor secara terpisah.',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.bookingItems.length,
                      itemBuilder: (context, index) {
                        return _buildVehicleAccordionCard(index, index + 1);
                      },
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                  ],
                ),
              ),
            ),
            _buildStickyBottomBar(),
          ],
        );
      }),
    );
  }

  Widget _buildVehicleAccordionCard(int itemIndex, int unitNumber) {
    return Obx(() {
      final item = controller.bookingItems[itemIndex];
      final isExpanded = controller.expandedCards[item.vehicle.id] ?? false;

      return Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: AppSpacing.cardShadow,
          border: Border.all(
            color: isExpanded ? AppColors.primary : AppColors.border,
            width: isExpanded ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () => controller.toggleCardExpanded(item.vehicle.id),
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryTint,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$unitNumber',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.vehicle.name,
                            style: AppTypography.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${item.vehicle.plateNumber} • ${item.serviceType?.name ?? "Belum pilih servis"}',
                            style: AppTypography.caption,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          Formatters.rupiah(item.subtotal),
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          Formatters.duration(item.duration),
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded) ...[
              const Divider(height: 1, color: AppColors.border),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pilih Tipe Servis', style: AppTypography.titleMedium),
                    const SizedBox(height: AppSpacing.md),
                    ...controller.availableServices.map((service) {
                      final isSelected = item.serviceType?.id == service.id;
                      return ServiceCard(
                        serviceType: service,
                        isSelected: isSelected,
                        onTap: () => controller.selectServiceForVehicle(
                          item.vehicle.id,
                          service,
                        ),
                      );
                    }),

                    const SizedBox(height: AppSpacing.lg),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: AppSpacing.md),

                    Text(
                      'Tambahan Oli & Sparepart (Opsional)',
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Centang sparepart yang ingin diganti sekaligus',
                      style: AppTypography.caption,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ...controller.availableParts.map((part) {
                      final isSelected = item.selectedParts.any(
                        (p) => p.id == part.id,
                      );
                      return CheckboxListTile(
                        value: isSelected,
                        onChanged: (_) => controller.togglePartForVehicle(
                          item.vehicle.id,
                          part,
                        ),
                        activeColor: AppColors.primary,
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          part.name,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        subtitle: Text(
                          part.category,
                          style: AppTypography.caption,
                        ),
                        secondary: Text(
                          Formatters.rupiah(part.price),
                          style: AppTypography.titleMedium.copyWith(
                            fontSize: 14,
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: AppSpacing.lg),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: AppSpacing.md),

                    Text(
                      'Catatan Keluhan Motor',
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Tuliskan keluhan atau kendala pada motor ${item.vehicle.name}',
                      style: AppTypography.caption,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      onChanged: (val) => controller.updateComplaintForVehicle(
                        item.vehicle.id,
                        val,
                      ),
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText:
                            'Contoh: Suara rem menghecit, akselerasi tarikan berat...',
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildStickyBottomBar() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontalPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Fleet (${controller.bookingItems.length} Unit)',
                  style: AppTypography.caption,
                ),
                Obx(
                  () => Text(
                    Formatters.rupiah(controller.grandTotalCost),
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    'Estimasi Total ${Formatters.duration(controller.grandTotalDuration)}',
                    style: AppTypography.caption,
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: PrimaryButton(
                label: 'Pilih Jadwal',
                icon: Icons.calendar_today,
                onPressed: controller.proceedToSchedule,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
