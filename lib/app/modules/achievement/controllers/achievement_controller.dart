import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../models/achievement_model.dart';

class AchievementController extends GetxController {
  final personalRecords = <PersonalRecordModel>[
    const PersonalRecordModel(
      id: 'streak_record',
      title: 'Rekor Streak',
      date: '25 Nov 2026',
      valueLabel: '7 Hari',
      // Isi imageAsset dengan path gambar kamu nanti, misal: 'assets/images/...'
      imageAsset: null,
      accentColor: AppColors.orange,
      softColor: AppColors.yellow50,
    ),
    const PersonalRecordModel(
      id: 'quiz_record',
      title: 'Skor Kuis Tertinggi',
      date: '24 Nov 2026',
      valueLabel: '100%',
      imageAsset: null,
      accentColor: AppColors.blue500,
      softColor: AppColors.blue50,
    ),
    const PersonalRecordModel(
      id: 'lesson_record',
      title: 'Materi Selesai',
      date: '23 Nov 2026',
      valueLabel: '12 Modul',
      imageAsset: null,
      accentColor: AppColors.green500,
      softColor: AppColors.green50,
    ),
  ].obs;

  final achievements = <AchievementModel>[
    const AchievementModel(
      id: 'api_semangat',
      title: 'Api Semangat',
      description:
          'Kamu meraih pencapaian Api Semangat karena berhasil menjaga streak belajarmu terus menyala!',
      unlockedDate: '26 NOV 2026',
      currentTier: 3,
      totalTiers: 7,
      imageAsset: 'assets/images/badge_api_semangat.svg',
      accentColor: AppColors.red500,
      softColor: AppColors.red50,
    ),
    const AchievementModel(
      id: 'burung_pagi',
      title: 'Burung Pagi',
      description:
          'Kamu meraih pencapaian Burung Pagi karena rutin belajar kimia sebelum jam 8 pagi!',
      unlockedDate: '25 NOV 2026',
      currentTier: 2,
      totalTiers: 10,
      imageAsset: 'assets/images/badge_burung_pagi.svg',
      accentColor: AppColors.red500,
      softColor: AppColors.red50,
    ),
    const AchievementModel(
      id: 'hattrick_sempurna',
      title: 'Hattrick Sempurna',
      description:
          'Kamu meraih pencapaian Hattrick Sempurna karena berhasil meraih nilai 100 di 3 kuis secara beruntun!',
      unlockedDate: '24 NOV 2026',
      currentTier: 1,
      totalTiers: 5,
      imageAsset: 'assets/images/badge_hattrick_sempurna.svg',
      accentColor: AppColors.green500,
      softColor: AppColors.green50,
    ),
    const AchievementModel(
      id: 'ingatan_baja',
      title: 'Ingatan Baja',
      description:
          'Kamu meraih pencapaian Ingatan Baja karena berhasil menghafal berbagai kartu flashcard!',
      unlockedDate: '23 NOV 2026',
      currentTier: 5,
      totalTiers: 10,
      imageAsset: 'assets/images/badge_ingatan_baja.svg',
      accentColor: AppColors.teal,
      softColor: AppColors.blue50,
    ),
    const AchievementModel(
      id: 'jago_kuis',
      title: 'Jago Kuis',
      description:
          'Kamu meraih pencapaian Jago Kuis karena berhasil menyelesaikan berbagai kuis kimia!',
      unlockedDate: '22 NOV 2026',
      currentTier: 4,
      totalTiers: 10,
      imageAsset: 'assets/images/badge_jago_kuis.svg',
      accentColor: AppColors.green500,
      softColor: AppColors.green50,
    ),
    const AchievementModel(
      id: 'otot_otak',
      title: 'Otot Otak',
      description:
          'Kamu meraih pencapaian Otot Otak karena rajin menyelesaikan latihan soal kimia!',
      unlockedDate: '21 NOV 2026',
      currentTier: 3,
      totalTiers: 10,
      imageAsset: 'assets/images/badge_otot_otak.svg',
      accentColor: AppColors.yellow700,
      softColor: AppColors.yellow50,
    ),
    const AchievementModel(
      id: 'penakluk_bab',
      title: 'Penakluk Bab',
      description:
          'Kamu meraih pencapaian Penakluk Bab karena berhasil menguasai seluruh materi dalam bab!',
      unlockedDate: '20 NOV 2026',
      currentTier: 2,
      totalTiers: 6,
      imageAsset: 'assets/images/badge_penakluk_bab.svg',
      accentColor: AppColors.blue500,
      softColor: AppColors.blue50,
    ),
    const AchievementModel(
      id: 'penjaga_malam',
      title: 'Penjaga Malam',
      description:
          'Kamu meraih pencapaian Penjaga Malam karena tetap semangat belajar kimia lewat jam 10 malam!',
      unlockedDate: '19 NOV 2026',
      currentTier: 1,
      totalTiers: 10,
      imageAsset: 'assets/images/badge_penjaga_malam.svg',
      accentColor: AppColors.red500,
      softColor: AppColors.red50,
    ),
    const AchievementModel(
      id: 'si_peracik',
      title: 'Si Peracik',
      description:
          'Coba simulasi eksperimen di laboratorium virtual untuk membuka pencapaian Si Peracik!',
      currentTier: 0,
      totalTiers: 5,
      imageAsset: 'assets/images/badge_si_peracik.svg',
      isUnlocked: false,
      accentColor: AppColors.orange,
      softColor: AppColors.yellow50,
    ),
  ].obs;
}
