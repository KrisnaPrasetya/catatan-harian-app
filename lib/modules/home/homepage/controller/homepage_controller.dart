import 'dart:convert';

import 'package:daily_notes_app/core/routes/app_routes.dart';
import 'package:daily_notes_app/core/services/local_storage_service.dart';
import 'package:daily_notes_app/modules/home/notepad_detail/controller/notepad_detail_controller.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  RxList<Map<String, dynamic>> notepads = <Map<String, dynamic>>[].obs;
  final LocalStorageService storage = LocalStorageService();
  String? currentUsername;

  @override
  void onInit() {
    super.onInit();
    loadNotepads();
  }

  // Fungsi untuk memuat catatan dari secure storage berdasarkan username
  Future<void> loadNotepads() async {
    if (currentUsername == null) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }
    final storedNotepads = await storage.read(key: 'notepads_$currentUsername');
    if (storedNotepads != null) {
      notepads.value = List<Map<String, dynamic>>.from(jsonDecode(storedNotepads));
      notepads.refresh();
      update();
    }
  }

  // Fungsi untuk menyimpan catatan ke secure storage
  Future<void> saveNotepads() async {
    if (currentUsername != null) {
      await storage.write(key: 'notepads_$currentUsername', value: jsonEncode(notepads));
    }
  }

  // Fungsi untuk menambahkan notepad baru
  Future<void> addNewNotepad() async {
    // check username
    if (currentUsername == null) {
      Get.snackbar('Error', 'Username tidak ditemukan, silahkan login kembali');
      Get.offAllNamed(AppRoutes.login);
      return;
    }
    Get.find<NotepadDetailController>().assignTextController(content: '', title: '');
    final result = await Get.toNamed(AppRoutes.detailNote, arguments: {'action': 'add', 'index_edit': -1});
    // Jika hasil edit ada, tambahkan notepad baru
    if (result != null) loadNotepads();
  }

  // Fungsi untuk mengedit notepad
  void editNotepad(Map<String, dynamic> notepad) async {
    notepad.forEach((key, value) {});
    Get.find<NotepadDetailController>().assignTextController(
      title: notepad['title'],
      content: notepad['content'],
    );
    final result = await Get.toNamed(AppRoutes.detailNote, arguments: {
      'action': 'edit',
      'index_edit': notepads.indexWhere((element) => element == notepad),
    });
    print('result: $result');
    // Jika hasil edit ada, perbarui notepad
    if (result != null) loadNotepads();
  }

  // Fungsi untuk menghapus notepad
  void deleteNotepad(Map<String, dynamic> notepad) {
    notepads.remove(notepad);
    saveNotepads();
    notepads.refresh();
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
