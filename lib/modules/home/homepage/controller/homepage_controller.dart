import 'package:daily_notes_app/core/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class HomePageController extends GetxController {
  var notepads = <Map<String, dynamic>>[].obs;
  final storage = const FlutterSecureStorage();
  String? currentUsername;

  @override
  void onInit() {
    super.onInit();
    loadNotepads(); // Memuat catatan ketika presenter diinisialisasi
  }

  // Fungsi untuk memuat catatan dari secure storage berdasarkan username
  Future<void> loadNotepads() async {
    if (currentUsername != null) {
      final storedNotepads =
          await storage.read(key: 'notepads_$currentUsername');
      if (storedNotepads != null) {
        notepads.value =
            List<Map<String, dynamic>>.from(jsonDecode(storedNotepads));
      }
    }
  }

  // Fungsi untuk menyimpan catatan ke secure storage
  Future<void> saveNotepads() async {
    if (currentUsername != null) {
      await storage.write(
          key: 'notepads_$currentUsername', value: jsonEncode(notepads));
    }
  }

  // Fungsi untuk menambahkan notepad baru
  void addNewNotepad() async {
    final result = await Get.toNamed(AppRoutes.detailnote);

    // Jika hasil edit ada, tambahkan notepad baru
    if (result != null) {
      notepads.add(result);
      saveNotepads(); 
      notepads.refresh(); 
    }
  }

  // Fungsi untuk mengedit notepad
  void editNotepad(Map<String, dynamic> notepad) async {
    final result = await Get.toNamed(AppRoutes.detailnote, arguments: notepad);

    if (result != null) {
      int index = notepads.indexWhere((element) => element == notepad);
      if (index != -1) {
        notepads[index] = result;
        saveNotepads(); // Simpan ke storage
        notepads.refresh();
      }
    }
  }

  // Fungsi untuk menghapus notepad
  void deleteNotepad(Map<String, dynamic> notepad) {
    notepads.remove(notepad);
    saveNotepads(); // Simpan ke storage
    notepads.refresh(); // Refresh UI untuk memperbarui daftar
  }

  // Fungsi untuk logout
  Future<void> logout() async {
    try {
      // Hanya hapus status login dan username dari secure storage
      await storage.delete(key: 'isLoggedIn');
      await storage.delete(key: 'currentUsername');

      // Arahkan pengguna ke halaman login
      Get.offAllNamed('/');
    } catch (e) {
      Get.snackbar('Error', 'Logout gagal, coba lagi');
    }
  }
}
