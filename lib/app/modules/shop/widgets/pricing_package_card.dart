import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../models/pricing_package_model.dart';

/// Kartu paket langganan bergaya Duolingo dengan palet AppColors KimiaXplore.
class PricingPackageCard extends StatelessWidget {
  final PricingPackageModel package;
  final bool isSelected;
  final bool isLoading;
  final VoidCallback? onTap;
  final VoidCallback? onSubscribe;

  const PricingPackageCard({
    super.key,
    required this.package,
    this.isSelected = false,
    this.isLoading = false,
    this.onTap,
    this.onSubscribe,
  });

  Widget _buildImageSlot() {
    final asset = package.imageAsset;
    if (asset != null && asset.isNotEmpty) {
      return SizedBox(
        width: 84,
        height: 84,
        child: asset.toLowerCase().endsWith('.svg')
            ? SvgPicture.asset(asset, fit: BoxFit.contain)
            : Image.asset(asset, fit: BoxFit.contain),
      );
    }

    return Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.image_outlined,
            size: 28,
            color: AppColors.textHint,
          ),
          const SizedBox(height: 2),
          Text(
            'Gambar',
            style: AppTypography.caption.copyWith(
              color: AppColors.textHint,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRecommended = package.isPopular;
    final features = package.features.isNotEmpty
        ? package.features
        : <String>[
            'Akses penuh seluruh materi & kuis',
            'Tutor Kimia AI lebih lengkap',
            'Belajar bebas iklan',
          ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isRecommended || isSelected
              ? AppColors.blue500
              : AppColors.border,
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Rekomendasi dengan maskot tanpa background khusus
                if (isRecommended) ...[
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/app_mascot.svg',
                        width: 28,
                        height: 28,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'REKOMENDASI',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.blue500,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Divider(color: AppColors.border, height: 1, thickness: 1.5),
                  const SizedBox(height: AppSpacing.md),
                ],

                // Isi utama: Judul & list keuntungan di kiri, slot gambar di kanan
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            package.title,
                            style: AppTypography.title.copyWith(
                              color: AppColors.textDark,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                package.localizedDuration,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textMedium,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              if (package.originalPrice != null) ...[
                                const SizedBox(width: 8),
                                Text(
                                  package.originalPrice!,
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.textHint,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: AppColors.textHint,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          ...features.map(
                            (feature) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Icon(
                                      Icons.check_rounded,
                                      size: 16,
                                      color: AppColors.blue500,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: AppTypography.bodySmall.copyWith(
                                        color: AppColors.textDark,
                                        fontWeight: FontWeight.w600,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    _buildImageSlot(),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                // Tombol CTA persis gaya Duolingo: menampilkan harga langsung di tombol
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: OutlinedButton(
                    onPressed: isLoading ? null : (onSubscribe ?? onTap),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isRecommended
                          ? AppColors.blue500
                          : AppColors.surface,
                      side: BorderSide(
                        color: isRecommended
                            ? AppColors.blue700
                            : AppColors.border,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.button),
                      ),
                    ),
                    child: Text(
                      isLoading
                          ? 'MEMPROSES...'
                          : 'COBA SEHARGA ${package.price.toUpperCase()}',
                      style: AppTypography.caption.copyWith(
                        color: isRecommended
                            ? AppColors.surface
                            : AppColors.blue500,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
