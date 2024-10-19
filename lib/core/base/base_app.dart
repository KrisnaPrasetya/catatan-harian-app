import 'package:daily_notes_app/core/routes/app_pages.dart';
import 'package:daily_notes_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      title: 'Aplikasi Catatan Harian',
      getPages: AppPages.pages,
    );
  }
}
