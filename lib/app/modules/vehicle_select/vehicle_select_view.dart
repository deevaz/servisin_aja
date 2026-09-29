import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';
import '../../core/widgets/vehicle_card.dart';
import 'vehicle_select_controller.dart';

class VehicleSelectView extends GetView<VehicleSelectController> {
  const VehicleSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Pilih Kendaraan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(AppSpacing.screenHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.primaryTint,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: AppColors.primary, size: 22),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              'Fitur Multi-Vehicle: Anda dapat mencentang lebih dari 1 motor untuk servis sekaligus.',
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
                    Text(
                      'Pilih Motor dari Garasi Anda (${controller.vehicles.length})',
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.vehicles.length,
                      itemBuilder: (context, index) {
                        final vehicle = controller.vehicles[index];
                        return Obx(() {
                          final isSelected = controller.selectedVehicleIds.contains(vehicle.id);
                          return VehicleCard(
                            vehicle: vehicle,
                            isSelected: isSelected,
                            onSelectedChanged: (_) => controller.toggleVehicleSelection(vehicle.id),
                          );
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SecondaryButton(
                      label: '+ Tambah Kendaraan Baru',
                      icon: Icons.add,
                      onPressed: () => _showAddVehicleSheet(context),
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
          )
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
                  'Terpilih',
                  style: AppTypography.caption,
                ),
                Obx(
                  () => Text(
                    '${controller.selectedVehicleIds.length} Kendaraan',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: PrimaryButton(
                label: 'Lanjut Atur Servis',
                icon: Icons.arrow_forward,
                onPressed: controller.proceedToServiceConfig,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddVehicleSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontalPadding),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Tambah Kendaraan Baru',
                style: AppTypography.headingMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Motor (e.g. Honda Beat)',
                  hintText: 'Masukkan nama motor',
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: controller.modelController,
                decoration: const InputDecoration(
                  labelText: 'Varian / Model (e.g. 110 CBS)',
                  hintText: 'Masukkan varian',
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: controller.plateController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Plat Nomor',
                  hintText: 'e.g. B 1234 XYZ',
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                label: 'Simpan Kendaraan',
                onPressed: controller.addNewVehicle,
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
