import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/utils/formatters.dart';
import 'invoice_detail_controller.dart';

class InvoiceDetailView extends GetView<InvoiceDetailController> {
  const InvoiceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final b = controller.booking;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Faktur & Invoice Resmi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.screenHorizontalPadding),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: AppSpacing.cardShadow,
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company & Invoice Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SERVISIN AJA',
                                style: AppTypography.headingMedium.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'AHASS Official Partner',
                                style: AppTypography.caption,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryTint,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'FAKTUR SERVIS',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: AppSpacing.md),

                    // Bill Info (FIX: Gunakan Expanded agar tidak tabrakan di tengah)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nomor Faktur:',
                                style: AppTypography.caption,
                              ),
                              Text(
                                b.code,
                                style: AppTypography.titleMedium.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tanggal Transaksi:',
                                style: AppTypography.caption,
                              ),
                              Text(
                                Formatters.formatDate(b.createdAt),
                                style: AppTypography.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12), // Jarak aman antar kolom
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Pelanggan:', style: AppTypography.caption),
                              Text(
                                'Aziz',
                                style: AppTypography.titleMedium.copyWith(
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Bengkel Layanan:',
                                style: AppTypography.caption,
                              ),
                              Text(
                                b.workshop.name,
                                style: AppTypography.bodyMedium,
                                textAlign: TextAlign
                                    .right, // FIX: Teks panjang diratakan kanan
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      'Rincian Item & Unit Motor',
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Itemized Table
                    ...b.items.map((item) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: AppSpacing.md),
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // FIX: Align top agar presisi kalau teks wrap 2 baris
                              children: [
                                // FIX: Gunakan Expanded agar nama motor panjang tidak mendorong harga ke luar layar
                                Expanded(
                                  child: Text(
                                    '${item.vehicle.name} (${item.vehicle.plateNumber})',
                                    style: AppTypography.titleMedium.copyWith(
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow
                                        .ellipsis, // Opsi tambahan agar rapi
                                  ),
                                ),
                                const SizedBox(width: 8), // Jarak ke harga
                                Text(
                                  Formatters.rupiah(item.subtotal),
                                  style: AppTypography.titleMedium.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '• Jasa: ${item.serviceType?.name} (${Formatters.rupiah(item.serviceType?.basePrice ?? 0)})',
                              style: AppTypography.caption,
                            ),
                            ...item.selectedParts.map(
                              (p) => Text(
                                '• Part: ${p.name} (${Formatters.rupiah(p.price)})',
                                style: AppTypography.caption,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: AppSpacing.lg),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: AppSpacing.md),

                    // Tax & Total calculation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal:', style: AppTypography.bodyMedium),
                        Text(
                          Formatters.rupiah((b.totalCost * 0.89).round()),
                          style: AppTypography.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'PPN 11% (Termasuk):',
                          style: AppTypography.bodyMedium,
                        ),
                        Text(
                          Formatters.rupiah((b.totalCost * 0.11).round()),
                          style: AppTypography.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: AppSpacing.sm),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Pembayaran:',
                          style: AppTypography.titleMedium.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          Formatters.rupiah(b.totalCost),
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
              child: PrimaryButton(
                label: 'Unduh Invoice PDF',
                icon: Icons.download,
                onPressed: controller.downloadPdfInvoice,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
