import 'package:daily_notes_app/core/routes/app_routes.dart';
import 'package:daily_notes_app/core/services/local_storage_service.dart';
import 'package:daily_notes_app/modules/home/homepage/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../../register/controller/register_controller.dart';

class LoginController extends GetxController {
  final LocalStorageService storage = LocalStorageService();
  final Rx<bool> isLoggedIn = false.obs, isPasswordHidden = true.obs;
  String? currentUsername;
  final TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void assignLogin({required String username, required String password}) {
    usernameController.text = username;
    passwordController.text = password;
    update();
  }

  // Fungsi untuk memeriksa status login
  Future<void> checkLoginStatus() async {
    final storedValue = await storage.read(key: 'isLoggedIn');
    if (storedValue == 'true') {
      currentUsername = await storage.read(key: 'currentUsername');
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    }
  }

  // Fungsi Login
  void login() async {
    final String username = usernameController.text,
        password = passwordController.text,
        usersJson = await storage.read(key: 'users') ?? '[]';

    final List users = json.decode(usersJson) as List;

    final user = users.firstWhere(
      (u) => u['username'] == username && u['password'] == password,
      orElse: () => null,
    );

    if (user != null) {
      currentUsername = username;
      await storage.write(key: 'isLoggedIn', value: 'true');
      await storage.write(key: 'currentUsername', value: username);
      isLoggedIn.value = true;

      // Atur username di HomePresenter sebelum mengarahkan ke halaman home
      final HomePageController homePresenter = Get.put(HomePageController());
      homePresenter.currentUsername = username;
      await homePresenter.loadNotepads();

      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Error', 'Username atau Password salah');
    }
  }

  // Fungsi untuk menampilkan atau menyembunyikan password
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Fungsi untuk pindah ke halaman register
  void toRegister() {
    Get.find<RegisterController>().assignRegister(
      username: '',
      password: '',
    );
    Get.toNamed(AppRoutes.register);
  }
}
