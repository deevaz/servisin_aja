import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/primary_button.dart';
import 'workshop_rating_controller.dart';

class WorkshopRatingView extends GetView<WorkshopRatingController> {
  const WorkshopRatingView({super.key});

  @override
  Widget build(BuildContext context) {
    final b = controller.booking;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Beri Ulasan Layanan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.screenHorizontalPadding),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                boxShadow: AppSpacing.cardShadow,
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryTint,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.storefront,
                      color: AppColors.primary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    b.workshop.name,
                    style: AppTypography.headingMedium,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Bagaimana pengalaman servis Anda di bengkel ini?',
                    style: AppTypography.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starValue = index + 1.0;
                        return IconButton(
                          iconSize: 38,
                          icon: Icon(
                            controller.rating.value >= starValue
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () => controller.setRating(starValue),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  TextField(
                    controller: controller.reviewController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText:
                          'Tuliskan ulasan Anda tentang kualitas pengerjaan, keramahan mekanik, dan kenyamanan bengkel...',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  Obx(
                    () => PrimaryButton(
                      label: 'Kirim Ulasan',
                      icon: Icons.send,
                      isLoading: controller.isSubmitting.value,
                      onPressed: controller.submitReview,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
