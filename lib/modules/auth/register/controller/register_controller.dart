import 'package:daily_notes_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class RegisterController extends GetxController {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Rx<bool> isPasswordHidden = true.obs;
  final TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Fungsi Register
  void register() async {
    try {
      final String username = usernameController.text,
          password = passwordController.text,
          usersJson = await storage.read(key: 'users') ?? '[]';
      final users = json.decode(usersJson) as List;

      //Memerikasa apakah username atau password kosong
      if (username.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'Masukkan Username dan Password');
        return;
      }

      // Memeriksa apakah username sudah digunakan
      if (users.any((u) => u['username'] == username)) {
        Get.snackbar('Gagal', 'Username sudah terdaftar, coba yang lain');
        return;
      }

      // Menambahkan pengguna baru
      users.add({'username': username, 'password': password});
      await storage.write(key: 'users', value: json.encode(users));

      Get.snackbar('Sukses', 'Registrasi berhasil');
      
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Error', 'Registrasi gagal');
    }
  }

  // Fungsi untuk menampilkan atau menyembunyikan password
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
}
