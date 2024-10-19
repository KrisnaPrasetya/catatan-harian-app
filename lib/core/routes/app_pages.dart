import 'package:daily_notes_app/modules/auth/login/screen/login_screen.dart';
import 'package:daily_notes_app/modules/auth/register/screen/register_screen.dart';
import 'package:daily_notes_app/modules/home/homepage/screen/homepage_screen.dart';
import 'package:daily_notes_app/modules/home/notepad_detail/screen/notepad_detail_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
    GetPage(name: AppRoutes.home, page: () => const HomePageScreen()),
    GetPage(name: AppRoutes.detailNote, page: () => const NotepadDetailScreen())
  ];
}
