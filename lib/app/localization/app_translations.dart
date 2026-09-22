import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'id_ID': {
        'nav_home': 'Home',
        'nav_lab': 'Lab',
        'nav_ai_tutor': 'AI Tutor',
        'nav_shop': 'Shop',
        'nav_profile': 'Profile',

        'settings_title': 'Pengaturan',
        'settings_account': 'Akun',
        'settings_purchase_history': 'Riwayat Pembelian',
        'settings_display_mode': 'Mode Tampilan',
        'settings_language': 'Bahasa',
        'settings_logout': 'Log out',
        'settings_logging_out': 'Keluar...',

        'purchase_history_title': 'Riwayat Pembelian',
        'purchase_history_unavailable':
            'Riwayat pembelian akan ditambahkan nanti.',

        'logout_title': 'Log out?',
        'logout_description':
            'Kamu perlu masuk lagi untuk menggunakan akun KimiaXplore.',
        'cancel': 'Batal',
        'logout_failed_title': 'Logout gagal',
        'logout_failed_description': 'Terjadi kesalahan saat keluar dari akun.',

        'ai_title': 'AI Tutor',
        'ai_welcome_title': 'Mau belajar apa hari ini?',
        'ai_welcome_description':
            'Tanyakan apa saja tentang kimia kepada Kimi!',
        'ai_input_hint': 'Tanyakan sesuatu tentang kimia...',
        'ai_thinking': 'Kimi sedang berpikir...',
        'ai_photo_title': 'Foto soal',
        'ai_photo_unavailable':
            'Fitur analisis foto soal akan ditambahkan setelah chat teks selesai.',
        'ai_history_title': 'Riwayat Chat',
        'ai_history_unavailable': 'Riwayat percakapan akan ditambahkan nanti.',

        'ai_error_prefix': 'Kimi belum bisa menjawab sekarang.',
        'ai_unexpected_error': 'Kimi mengalami kesalahan yang tidak terduga.',

        'account_title': 'Akun',
        'account_information': 'Informasi Akun',
        'account_description': 'Kelola informasi akun KimiaXplore kamu.',
        'username': 'Username',
        'email': 'Email',
        'save_changes': 'Simpan Perubahan',
        'saving': 'Menyimpan...',

        'profile_completed_topics': 'Topik Selesai',
        'profile_total_badges': 'Total Badge',
        'profile_recent_activity': 'Aktivitas Terakhir',
        'profile_no_activity': 'Belum ada aktivitas belajar',

        'status_completed': 'Selesai',
        'status_opened': 'Dibuka',
        'score': 'Skor',
      },

      'en_US': {
        'nav_home': 'Home',
        'nav_lab': 'Lab',
        'nav_ai_tutor': 'AI Tutor',
        'nav_shop': 'Shop',
        'nav_profile': 'Profile',

        'settings_title': 'Settings',
        'settings_account': 'Account',
        'settings_purchase_history': 'Purchase History',
        'settings_display_mode': 'Display Mode',
        'settings_language': 'Language',
        'settings_logout': 'Log out',
        'settings_logging_out': 'Logging out...',

        'purchase_history_title': 'Purchase History',
        'purchase_history_unavailable':
            'Purchase history will be available later.',

        'logout_title': 'Log out?',
        'logout_description':
            'You will need to sign in again to use your KimiaXplore account.',
        'cancel': 'Cancel',
        'logout_failed_title': 'Logout failed',
        'logout_failed_description':
            'Something went wrong while logging out of your account.',

        'ai_title': 'AI Tutor',
        'ai_welcome_title': 'What do you want to learn today?',
        'ai_welcome_description': 'Ask Kimi anything about chemistry!',
        'ai_input_hint': 'Ask something about chemistry...',
        'ai_thinking': 'Kimi is thinking...',
        'ai_photo_title': 'Question photo',
        'ai_photo_unavailable':
            'Photo question analysis will be added after text chat is complete.',
        'ai_history_title': 'Chat History',
        'ai_history_unavailable': 'Chat history will be available later.',

        'ai_error_prefix': 'Kimi cannot answer right now.',
        'ai_unexpected_error': 'Kimi encountered an unexpected error.',

        'account_title': 'Account',
        'account_information': 'Account Information',
        'account_description': 'Manage your KimiaXplore account information.',
        'username': 'Username',
        'email': 'Email',
        'save_changes': 'Save Changes',
        'saving': 'Saving...',

        'profile_completed_topics': 'Completed Topics',
        'profile_total_badges': 'Total Badges',
        'profile_recent_activity': 'Recent Activity',
        'profile_no_activity': 'No learning activity yet',

        'status_completed': 'Completed',
        'status_opened': 'Opened',
        'score': 'Score',
      },
    };
  }
}
