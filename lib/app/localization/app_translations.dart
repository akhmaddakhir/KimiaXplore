import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'id_ID': {
        // Nav
        'nav_home': 'Home',
        'nav_lab': 'Lab',
        'nav_ai_tutor': 'AI Tutor',
        'nav_shop': 'Shop',
        'nav_profile': 'Profile',

        // Settings
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

        // AI Tutor
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

        // Account
        'account_title': 'Akun',
        'account_information': 'Informasi Akun',
        'account_description': 'Kelola informasi akun KimiaXplore kamu.',
        'username': 'Username',
        'email': 'Email',
        'save_changes': 'Simpan Perubahan',
        'saving': 'Menyimpan...',

        // Profile
        'profile_completed_topics': 'Topik Selesai',
        'profile_total_badges': 'Total Badge',
        'profile_recent_activity': 'Aktivitas Terakhir',
        'profile_no_activity': 'Belum ada aktivitas belajar',
        'profile_status_score': 'Skor @score%',
        'profile_status_completed': 'Selesai',
        'profile_status_opened': 'Dibuka',
        'time_just_now': 'Baru saja',
        'time_minutes_ago': '@m menit lalu',
        'time_hours_ago': '@h jam lalu',
        'time_yesterday': 'Kemarin',
        'time_days_ago': '@d hari lalu',
        'profile_update_success_title': 'Berhasil',
        'profile_update_success_desc': 'Username berhasil diperbarui.',
        'profile_update_failed_title': 'Gagal memperbarui username',
        'profile_update_failed_desc':
            'Terjadi kesalahan saat menyimpan perubahan.',
        'profile_username_empty_title': 'Username belum diisi',
        'profile_username_empty_desc': 'Masukkan username terlebih dahulu.',
        'profile_username_short_title': 'Username terlalu pendek',
        'profile_username_short_desc': 'Username minimal 3 karakter.',
        'profile_no_changes_title': 'Tidak ada perubahan',
        'profile_no_changes_desc': 'Username kamu masih sama.',

        // Home
        'home_greeting': 'Halo, @name!',
        'home_explore_prompt': 'Mau xplore apa hari ini?',
        'home_continue_learning': 'Lanjutkan Belajar',
        'home_recommended_topic': 'Rekomendasi Materi',
        'home_continue': 'Lanjutkan',
        'home_try_now': 'Coba Sekarang',
        'home_completed': 'selesai',
        'home_chemistry_foundations': 'Fondasi Kimia',
        'home_foundations_desc': 'Konsep utama untuk memulai perjalananmu.',
        'home_study_progress': 'Progres Belajar',
        'home_lessons': 'pelajaran',
        'home_materials': 'materi',

        // Topics
        'topic_atomic_structure_title': 'Struktur Atom',
        'topic_atomic_structure_desc':
            'Kenali partikel kecil yang jadi dasar segalanya.',
        'topic_periodic_table_title': 'Sistem Periodik',
        'topic_periodic_table_desc':
            'Bukan sekadar tabel, setiap unsur punya ceritanya.',
        'topic_chemical_bonding_title': 'Ikatan Kimia',
        'topic_chemical_bonding_desc':
            'Cari tahu kenapa atom bisa saling terikat.',
        'topic_level_basic': 'Dasar',

        // Topic Detail
        'topic_detail_title': 'Detail',
        'topic_select_first': 'Pilih materi terlebih dahulu',
        'topic_activities': 'Aktivitas',
        'topic_learning_progress': 'Progress Belajar',
        'topic_continue_activity': 'Lanjutkan aktivitas',
        'topic_recommended_activity': 'Rekomendasi aktivitas',
        'topic_continue_learning': 'Lanjutkan Belajar',
        'topic_start_learning': 'Mulai Pembelajaran',
        'topic_start_now': 'Mulai Sekarang',
        'topic_act_material_title': 'Materi',
        'topic_act_material_sub': 'Pelajari teori dan konsep kimia',
        'topic_act_flashcard_title': 'Flashcard',
        'topic_act_flashcard_sub': 'Hafalkan istilah dan rumus penting',
        'topic_act_quiz_title': 'Kuis',
        'topic_act_quiz_sub': 'Uji pemahaman dan latihan soal',
        'topic_act_simulation_title': 'Simulasi',
        'topic_act_simulation_sub': 'Eksperimen virtual interaktif',

        // Material
        'material_title': 'Materi',
        'material_lesson_list': 'Daftar Pelajaran',
        'material_choose_lesson': 'Pilih pelajaran yang ingin kamu pelajari.',
        'material_lesson_prefix': 'Pelajaran',
        'material_loading_progress': 'Memuat progress...',
        'material_progress_completed':
            '@completed dari @total pelajaran selesai',
        'material_not_found': 'Topik tidak ditemukan',
        'material_unavailable': 'Materi belum tersedia',
        'material_chemistry_level': 'Kimia @level',
        'material_lesson_counter': 'Pelajaran @current dari @total',
        'material_next_lesson': 'Pelajaran Selanjutnya',
        'material_continue_to_quiz': 'Lanjut ke Kuis',
        'material_complete': 'Selesai',

        // Quiz
        'quiz_check': 'Cek',
        'quiz_continue': 'Lanjut',
        'quiz_explanation': 'Pembahasan',
        'quiz_explanation_unavailable':
            'Pembahasan untuk soal ini belum tersedia.',
        'quiz_evaluation_time': 'Saatnya evaluasi',
        'quiz_correct': 'Benar',
        'quiz_incorrect': 'Salah',
        'quiz_discussion': 'Pembahasan',
        'quiz_continue_to_flashcard': 'Lanjut ke Flashcard',
        'quiz_finish': 'Selesai',
        'quiz_practice_completed': 'Latihan selesai!',
        'quiz_total_score': 'Skor Total',
        'quiz_evaluation_title': 'Evaluasi',

        // Flashcard
        'flashcard_empty': 'Belum ada flashcard untuk topik ini.',
        'flashcard_need_practice': 'Belum Hafal',
        'flashcard_memorized': 'Hafal',
        'flashcard_question': 'Pertanyaan',
        'flashcard_answer': 'Jawaban',
        'flashcard_view_answer': 'Lihat jawaban',
        'flashcard_view_question': 'Lihat pertanyaan',
        'flashcard_completed_title': 'Flashcard Selesai!',
        'flashcard_completed_desc': 'Kamu sudah mempelajari semua kartu.',
        'flashcard_retry_need_practice': 'Ulangi yang Belum Hafal',
        'flashcard_back_to_topic': 'Kembali ke Topik',

        // Lab
        'lab_title': 'Lab',
        'lab_simulations': 'Simulasi Kimia',
        'lab_desc': 'Eksperimen tanpa bikin meja meledak.',
        'lab_view_all': 'Lihat semua',
        'simulation_periodic_table_title': 'Tabel Periodik',
        'simulation_periodic_table_desc':
            'Jelajahi unsur kimia dan kenali sifat-sifatnya.',
        'simulation_electron_configuration_title': 'Konfigurasi Elektron',
        'simulation_electron_configuration_desc':
            'Pelajari susunan elektron di dalam atom.',
        'simulation_states_of_matter_title': 'Wujud Zat',
        'simulation_states_of_matter_desc':
            'Amati perubahan wujud zat dan gerakan partikelnya.',
        'simulation_title': 'Simulasi',
        'simulation_particles_title': 'Lihat partikel berubah',
        'simulation_particles_desc':
            'Geser suhu dan amati bagaimana susunan serta gerakan partikel berubah dari padat, cair, hingga gas.',
        'simulation_reset': 'Reset Simulasi',
        'simulation_unavailable_title': 'Simulasi belum tersedia',
        'simulation_unavailable_desc':
            'Eksperimen ini masih disiapkan. Coba Wujud Zat terlebih dahulu.',
        'simulation_back_to_lab': 'Kembali ke Lab',
        'simulation_topic_unavailable_desc':
            'Simulasi untuk @topic masih dalam pengembangan.',
        'temperature': 'Suhu',
        'simulation_water_example_note':
            'Simulasi menggunakan air sebagai contoh pada kondisi normal.',
        'matter_solid': 'Padat',
        'matter_liquid': 'Cair',
        'matter_gas': 'Gas',
        'matter_solid_desc':
            'Partikel tersusun sangat rapat dan hanya bergetar di sekitar posisinya.',
        'matter_liquid_desc':
            'Partikel tetap berdekatan, tetapi dapat bergerak dan bergeser satu sama lain.',
        'matter_gas_desc':
            'Partikel berjauhan dan bergerak bebas dengan kecepatan yang lebih tinggi.',
        'matter_solid_behavior': 'Rapat dan teratur',
        'matter_liquid_behavior': 'Dekat dan bergerak',
        'matter_gas_behavior': 'Renggang dan bebas',

        // Shop
        'shop_title': 'KimiaXplore Premium',
        'shop_benefits': 'Manfaat',
        'shop_free': 'Gratis',
        'shop_premium': 'Premium',
        'shop_choose_plan': 'Pilih Paket Premium',
        'shop_choose_desc':
            'Pilih paket yang paling sesuai dengan cara belajarmu.',
        'shop_intro_title': 'Makin Banyak Tanya, Makin Banyak Paham',
        'shop_intro_desc':
            'Dapatkan akses AI Tutor lebih lengkap dengan batas penggunaan yang lebih besar.',
        'shop_view_plans': 'Lihat Paket Premium',
        'shop_continue': 'Lanjutkan',
        'shop_access_duration': 'Akses Xplore+ selama @duration',
        'shop_best_value': 'Paling Hemat',
        'shop_badge_yearly': 'Paling Hemat',
        'shop_benefit_ai_tutor_access': 'AI Tutor lebih lengkap',
        'shop_benefit_ai_tutor_usage': 'Usage lebih banyak',
        'shop_benefit_ad_free_learning': 'Belajar tanpa iklan',
        'shop_benefit_upcoming_features': 'Akses fitur baru lebih awal',
        'shop_duration_yearly': '12 bulan',
        'shop_duration_quarterly': '3 bulan',
        'shop_duration_monthly': '1 bulan',

        // Welcome & Auth
        'welcome_explore_further': 'Xplore Lebih Jauh',
        'welcome_desc': 'Kimia nggak cuma soal hafalan.',
        'welcome_start': 'Mulai',
        'welcome_have_account': 'Saya sudah punya akun',
        'auth_login': 'Masuk',
        'auth_email_hint': 'Masukkan email kamu',
        'auth_password': 'Sandi',
        'auth_password_hint': 'Masukkan sandi kamu',
        'auth_no_account': 'Belum punya akun? ',
        'auth_sign_up_action': 'Gas bikin',
        'auth_ready_start': 'Siap Mulai?',
        'auth_password_min': 'Minimal 6 karakter',
        'auth_confirm_password': 'Konfirmasi sandi',
        'auth_confirm_password_hint': 'Masukkan ulang sandi kamu',
        'auth_register': 'Daftar',
        'auth_or': 'Atau',

        // Onboarding
        'onboarding_intro_msg': 'Halo Xplorer!',
        'onboarding_lets_meet': 'Kenalan, yuk!',
        'onboarding_react_title': 'Saatnya Bereaksi!',
        'onboarding_react_subtitle':
            'Kalau atom aja bisa berikatan, masa kamu sama kimia cuma sebatas kenalan?',
        'onboarding_q_discovery_source': 'Darimana tau KimiaXplore?',
        'onboarding_opt_instagram': 'Instagram',
        'onboarding_opt_tiktok': 'Tiktok',
        'onboarding_opt_friends_family': 'Teman atau orang terdekat',
        'onboarding_opt_google_search': 'Google search',
        'onboarding_opt_website_blog': 'Website/blog',
        'onboarding_opt_other': 'Lainnya',
        'onboarding_q_chemistry_level': 'Sejauh mana kamu kenal kimia?',
        'onboarding_opt_beginner': 'Baru kenalan',
        'onboarding_opt_intermediate': 'Udah tau dikit',
        'onboarding_opt_advanced': 'Lumayan paham',
        'onboarding_opt_expert': 'Kimia? Cemilan sehari-hari 😎',
        'onboarding_q_learning_goal': 'Mau ngapain di KimiaXplore?',
        'onboarding_opt_learn_basics': 'Belajar dari nol',
        'onboarding_opt_improve': 'Biar makin paham',
        'onboarding_opt_exam': 'Persiapan ulangan',
        'onboarding_opt_practice': 'Latihan soal',
        'onboarding_opt_simulation': 'Belajar lewat simulasi',
        'onboarding_opt_explore': 'Iseng xplore aja',
        'onboarding_opt_survive': 'Biar nggak pusing sama kimia 😭',
        'onboarding_q_learning_preference': 'Kamu paling suka belajar gimana?',
        'onboarding_opt_reading': 'Baca materi',
        'onboarding_opt_challenge': 'Belajar sambil ngerjain soal',
        'onboarding_opt_flashcard': 'Hafalan pakai kartu',
        'onboarding_opt_mixed': 'Apa aja, yang penting paham 😎',
      },

      'en_US': {
        // Nav
        'nav_home': 'Home',
        'nav_lab': 'Lab',
        'nav_ai_tutor': 'AI Tutor',
        'nav_shop': 'Shop',
        'nav_profile': 'Profile',

        // Settings
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

        // AI Tutor
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

        // Account
        'account_title': 'Account',
        'account_information': 'Account Information',
        'account_description': 'Manage your KimiaXplore account information.',
        'username': 'Username',
        'email': 'Email',
        'save_changes': 'Save Changes',
        'saving': 'Saving...',

        // Profile
        'profile_completed_topics': 'Completed Topics',
        'profile_total_badges': 'Total Badges',
        'profile_recent_activity': 'Recent Activity',
        'profile_no_activity': 'No learning activity yet',
        'profile_status_score': 'Score @score%',
        'profile_status_completed': 'Completed',
        'profile_status_opened': 'Opened',
        'time_just_now': 'Just now',
        'time_minutes_ago': '@m min ago',
        'time_hours_ago': '@h hrs ago',
        'time_yesterday': 'Yesterday',
        'time_days_ago': '@d days ago',
        'profile_update_success_title': 'Success',
        'profile_update_success_desc': 'Username successfully updated.',
        'profile_update_failed_title': 'Failed to update username',
        'profile_update_failed_desc': 'An error occurred while saving changes.',
        'profile_username_empty_title': 'Username is required',
        'profile_username_empty_desc': 'Please enter a username first.',
        'profile_username_short_title': 'Username is too short',
        'profile_username_short_desc':
            'Username must be at least 3 characters.',
        'profile_no_changes_title': 'No changes',
        'profile_no_changes_desc': 'Your username is still the same.',

        // Home
        'home_greeting': 'Hello, @name!',
        'home_explore_prompt': 'What do you want to explore today?',
        'home_continue_learning': 'Continue Learning',
        'home_recommended_topic': 'Recommended Topic',
        'home_continue': 'Continue',
        'home_try_now': 'Try Now',
        'home_completed': 'completed',
        'home_chemistry_foundations': 'Chemistry Foundations',
        'home_foundations_desc': 'Core concepts to start your journey.',
        'home_study_progress': 'Learning Progress',
        'home_lessons': 'lessons',
        'home_materials': 'materials',

        // Topics
        'topic_atomic_structure_title': 'Atomic Structure',
        'topic_atomic_structure_desc':
            'Learn about the tiny particles that form everything.',
        'topic_periodic_table_title': 'Periodic Table',
        'topic_periodic_table_desc':
            'Not just a table, every element has a story.',
        'topic_chemical_bonding_title': 'Chemical Bonding',
        'topic_chemical_bonding_desc': 'Find out why atoms bond together.',
        'topic_level_basic': 'Basic',

        // Topic Detail
        'topic_detail_title': 'Detail',
        'topic_select_first': 'Please select a topic first',
        'topic_activities': 'Activities',
        'topic_learning_progress': 'Learning Progress',
        'topic_continue_activity': 'Continue activity',
        'topic_recommended_activity': 'Recommended activity',
        'topic_continue_learning': 'Continue Learning',
        'topic_start_learning': 'Start Learning',
        'topic_start_now': 'Start Now',
        'topic_act_material_title': 'Lessons',
        'topic_act_material_sub': 'Learn chemistry theory and concepts',
        'topic_act_flashcard_title': 'Flashcards',
        'topic_act_flashcard_sub': 'Memorize important terms and formulas',
        'topic_act_quiz_title': 'Quiz',
        'topic_act_quiz_sub': 'Test understanding and practice questions',
        'topic_act_simulation_title': 'Simulation',
        'topic_act_simulation_sub': 'Interactive virtual experiments',

        // Material
        'material_title': 'Lessons',
        'material_lesson_list': 'Lesson List',
        'material_choose_lesson': 'Choose a lesson you want to learn.',
        'material_lesson_prefix': 'Lesson',
        'material_loading_progress': 'Loading progress...',
        'material_progress_completed': '@completed of @total lessons completed',
        'material_not_found': 'Topic not found',
        'material_unavailable': 'Material not yet available',
        'material_chemistry_level': '@level Chemistry',
        'material_lesson_counter': 'Lesson @current of @total',
        'material_next_lesson': 'Next Lesson',
        'material_continue_to_quiz': 'Continue to Quiz',
        'material_complete': 'Complete',

        // Quiz
        'quiz_check': 'Check',
        'quiz_continue': 'Continue',
        'quiz_explanation': 'Explanation',
        'quiz_explanation_unavailable':
            'Explanation for this question is not yet available.',
        'quiz_evaluation_time': 'Time for evaluation',
        'quiz_correct': 'Correct',
        'quiz_incorrect': 'Incorrect',
        'quiz_discussion': 'Discussion',
        'quiz_continue_to_flashcard': 'Continue to Flashcards',
        'quiz_finish': 'Complete',
        'quiz_practice_completed': 'Practice completed!',
        'quiz_total_score': 'Total Score',
        'quiz_evaluation_title': 'Evaluation',

        // Flashcard
        'flashcard_empty': 'No flashcards for this topic yet.',
        'flashcard_need_practice': 'Need Practice',
        'flashcard_memorized': 'Memorized',
        'flashcard_question': 'Question',
        'flashcard_answer': 'Answer',
        'flashcard_view_answer': 'Tap to see answer',
        'flashcard_view_question': 'Tap to see question',
        'flashcard_completed_title': 'Flashcards Completed!',
        'flashcard_completed_desc': 'You have studied all cards.',
        'flashcard_retry_need_practice': 'Review Need Practice',
        'flashcard_back_to_topic': 'Back to Topic',

        // Lab
        'lab_title': 'Lab',
        'lab_simulations': 'Chemistry Simulations',
        'lab_desc': 'Experiment safely without exploding your desk.',
        'lab_view_all': 'View all',
        'simulation_periodic_table_title': 'Periodic Table',
        'simulation_periodic_table_desc':
            'Explore chemical elements and discover their properties.',
        'simulation_electron_configuration_title': 'Electron Configuration',
        'simulation_electron_configuration_desc':
            'Learn the electron arrangement within atoms.',
        'simulation_states_of_matter_title': 'States of Matter',
        'simulation_states_of_matter_desc':
            'Observe state changes and particle movements.',
        'simulation_title': 'Simulation',
        'simulation_particles_title': 'Watch particles change',
        'simulation_particles_desc':
            'Adjust the temperature and observe how particle arrangement and motion change from solid to liquid to gas.',
        'simulation_reset': 'Reset Simulation',
        'simulation_unavailable_title': 'Simulation not available yet',
        'simulation_unavailable_desc':
            'This experiment is still being prepared. Try States of Matter first.',
        'simulation_back_to_lab': 'Back to Lab',
        'simulation_topic_unavailable_desc':
            'Simulation for @topic is still in development.',
        'temperature': 'Temperature',
        'simulation_water_example_note':
            'Simulation uses water as an example under standard conditions.',
        'matter_solid': 'Solid',
        'matter_liquid': 'Liquid',
        'matter_gas': 'Gas',
        'matter_solid_desc':
            'Particles are tightly packed and only vibrate in their fixed positions.',
        'matter_liquid_desc':
            'Particles remain close, but can move and slide past one another.',
        'matter_gas_desc':
            'Particles are far apart and move freely at higher speeds.',
        'matter_solid_behavior': 'Tightly packed and orderly',
        'matter_liquid_behavior': 'Close and moving',
        'matter_gas_behavior': 'Spaced out and free',

        // Shop
        'shop_title': 'KimiaXplore Premium',
        'shop_benefits': 'Benefits',
        'shop_free': 'Free',
        'shop_premium': 'Premium',
        'shop_choose_plan': 'Choose Premium Plan',
        'shop_choose_desc': 'Choose the plan that best fits your study habits.',
        'shop_intro_title': 'Ask More, Understand Better',
        'shop_intro_desc': 'Get full AI Tutor access with higher usage limits.',
        'shop_view_plans': 'View Premium Plans',
        'shop_continue': 'Continue',
        'shop_access_duration': 'Xplore+ access for @duration',
        'shop_best_value': 'Best Value',
        'shop_badge_yearly': 'Best Value',
        'shop_benefit_ai_tutor_access': 'Comprehensive AI Tutor',
        'shop_benefit_ai_tutor_usage': 'Higher usage limits',
        'shop_benefit_ad_free_learning': 'Ad-free learning',
        'shop_benefit_upcoming_features': 'Early access to new features',
        'shop_duration_yearly': '12 months',
        'shop_duration_quarterly': '3 months',
        'shop_duration_monthly': '1 month',

        // Welcome & Auth
        'welcome_explore_further': 'Explore Further',
        'welcome_desc': 'Chemistry is not just memorization.',
        'welcome_start': 'Get Started',
        'welcome_have_account': 'I already have an account',
        'auth_login': 'Log in',
        'auth_email_hint': 'Enter your email',
        'auth_password': 'Password',
        'auth_password_hint': 'Enter your password',
        'auth_no_account': "Don't have an account? ",
        'auth_sign_up_action': 'Sign up',
        'auth_ready_start': 'Ready to Start?',
        'auth_password_min': 'Minimum 6 characters',
        'auth_confirm_password': 'Confirm password',
        'auth_confirm_password_hint': 'Re-enter your password',
        'auth_register': 'Sign up',
        'auth_or': 'Or',

        // Onboarding
        'onboarding_intro_msg': 'Hello Xplorer!',
        'onboarding_lets_meet': "Let's meet!",
        'onboarding_react_title': 'Time to React!',
        'onboarding_react_subtitle':
            'If atoms can bond, why should chemistry just be an acquaintance?',
        'onboarding_q_discovery_source': 'How did you find KimiaXplore?',
        'onboarding_opt_instagram': 'Instagram',
        'onboarding_opt_tiktok': 'Tiktok',
        'onboarding_opt_friends_family': 'Friends or family',
        'onboarding_opt_google_search': 'Google search',
        'onboarding_opt_website_blog': 'Website/blog',
        'onboarding_opt_other': 'Other',
        'onboarding_q_chemistry_level': 'How well do you know chemistry?',
        'onboarding_opt_beginner': 'Just getting started',
        'onboarding_opt_intermediate': 'Know a little bit',
        'onboarding_opt_advanced': 'Fairly comfortable',
        'onboarding_opt_expert': 'Chemistry? A piece of cake 😎',
        'onboarding_q_learning_goal': 'What is your goal with KimiaXplore?',
        'onboarding_opt_learn_basics': 'Learn from scratch',
        'onboarding_opt_improve': 'Deepen understanding',
        'onboarding_opt_exam': 'Exam preparation',
        'onboarding_opt_practice': 'Practice questions',
        'onboarding_opt_simulation': 'Learn through simulations',
        'onboarding_opt_explore': 'Just exploring',
        'onboarding_opt_survive': 'Survive chemistry without headaches 😭',
        'onboarding_q_learning_preference': 'How do you like to learn best?',
        'onboarding_opt_reading': 'Read lessons',
        'onboarding_opt_challenge': 'Learn through questions',
        'onboarding_opt_flashcard': 'Flashcard memorization',
        'onboarding_opt_mixed': 'Anything, as long as I understand 😎',
      },
    };
  }
}
