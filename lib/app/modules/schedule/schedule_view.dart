import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/section_header.dart';
import '../../core/utils/formatters.dart';
import 'schedule_controller.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Pilih Bengkel & Waktu'),
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
                    const SectionHeader(title: 'Pilih Bengkel AHASS'),
                    const SizedBox(height: AppSpacing.md),
                    ...controller.workshops.map((ws) {
                      return Obx(() {
                        final isSelected =
                            controller.selectedWorkshop.value?.id == ws.id;
                        return Container(
                          margin: const EdgeInsets.only(bottom: AppSpacing.md),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryTint
                                : AppColors.card,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.cardRadius,
                            ),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.border,
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: isSelected ? [] : AppSpacing.cardShadow,
                          ),
                          child: InkWell(
                            onTap: () => controller.selectWorkshop(ws),
                            borderRadius: BorderRadius.circular(
                              AppSpacing.cardRadius,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.lg),
                              child: Row(
                                children: [
                                  Icon(
                                    isSelected
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textMuted,
                                    size: 22,
                                  ),
                                  const SizedBox(width: AppSpacing.xs),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ws.name,
                                          style: AppTypography.titleMedium,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          ws.address,
                                          style: AppTypography.bodyMedium,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 14,
                                              color: Colors.amber,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${ws.rating} (${ws.reviewCount})',
                                              style: AppTypography.caption
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            const SizedBox(width: 12),
                                            const Icon(
                                              Icons.location_on_outlined,
                                              size: 14,
                                              color: AppColors.textMuted,
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              '${ws.distanceKm} km',
                                              style: AppTypography.caption,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    }),

                    const SizedBox(height: AppSpacing.lg),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: AppSpacing.md),

                    const SectionHeader(title: 'Pilih Tanggal Servis'),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.availableDates.length,
                        itemBuilder: (context, index) {
                          final date = controller.availableDates[index];
                          return Obx(() {
                            final isSelected =
                                controller.selectedDate.value.year ==
                                    date.year &&
                                controller.selectedDate.value.month ==
                                    date.month &&
                                controller.selectedDate.value.day == date.day;

                            return Container(
                              width: 72,
                              margin: const EdgeInsets.only(
                                right: AppSpacing.sm,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.card,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.border,
                                ),
                                boxShadow: isSelected
                                    ? []
                                    : AppSpacing.cardShadow,
                              ),
                              child: InkWell(
                                onTap: () => controller.selectDate(date),
                                borderRadius: BorderRadius.circular(16),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        Formatters.formatShortDate(
                                          date,
                                        ).split(' ')[1],
                                        style: AppTypography.caption.copyWith(
                                          color: isSelected
                                              ? Colors.white70
                                              : AppColors.textMuted,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${date.day}',
                                        style: AppTypography.headingMedium
                                            .copyWith(
                                              color: isSelected
                                                  ? Colors.white
                                                  : AppColors.textPrimary,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: AppSpacing.md),

                    const SectionHeader(title: 'Pilih Jam Kedatangan'),
                    const SizedBox(height: AppSpacing.md),
                    Obx(
                      () => Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: controller.timeSlots.map((slot) {
                          final isSelected =
                              controller.selectedTime.value == slot.time;
                          final isAvailable = slot.available;

                          return InkWell(
                            onTap: isAvailable
                                ? () => controller.selectTimeSlot(slot.time)
                                : null,
                            borderRadius: BorderRadius.circular(12),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: !isAvailable
                                    ? AppColors.surface
                                    : isSelected
                                    ? AppColors.primary
                                    : AppColors.card,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: !isAvailable
                                      ? AppColors.border
                                      : isSelected
                                      ? AppColors.primary
                                      : AppColors.border,
                                ),
                              ),
                              child: Text(
                                slot.time,
                                style: AppTypography.titleMedium.copyWith(
                                  fontSize: 14,
                                  color: !isAvailable
                                      ? AppColors.textMuted
                                      : isSelected
                                      ? Colors.white
                                      : AppColors.textPrimary,
                                  decoration: !isAvailable
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
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
        child: PrimaryButton(
          label: 'Lanjut Ringkasan Booking',
          icon: Icons.assignment_outlined,
          onPressed: controller.proceedToSummary,
        ),
      ),
    );
  }
}
