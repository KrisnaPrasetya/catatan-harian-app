import 'dart:convert';

import 'package:daily_notes_app/core/routes/app_routes.dart';
import 'package:daily_notes_app/core/services/local_storage_service.dart';
import 'package:daily_notes_app/modules/home/notepad_detail/controller/notepad_detail_controller.dart';
import 'package:flutter/material.dart';
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
      await Future.delayed(Duration(seconds: 1));
      Get.offAllNamed(AppRoutes.login);
      return;
    }
    final storedNotepads = await storage.read(key: 'notepads_$currentUsername');
    if (storedNotepads != null) {
      notepads.value =
          List<Map<String, dynamic>>.from(jsonDecode(storedNotepads));
      notepads.refresh();
      update();
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
  Future<void> addNewNotepad() async {
    // check username
    if (currentUsername == null) {
      Get.snackbar('Error', 'Username tidak ditemukan, silahkan login kembali');
      Get.offAllNamed(AppRoutes.login);
      return;
    }
    Get.find<NotepadDetailController>()
        .assignTextController(content: '', title: '');
    final result = await Get.toNamed(AppRoutes.detailNote,
        arguments: {'action': 'add', 'index_edit': -1});
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
    // print('result: $result');
    // Jika hasil edit ada, perbarui notepad
    if (result != null) loadNotepads();
  }

  void deleteNotepad(Map<String, dynamic> notepad) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: Get.width > 450 ? 450 : Get.width * 0.9,
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.delete_forever, size: 48, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Hapus notepad',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Apakah Anda yakin ingin menghapus notepad ini?',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      child: Text('Batal'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        notepads.remove(notepad);
                        saveNotepads();
                        notepads.refresh();
                        Get.back();
                      },
                      child: Text('Hapus'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
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
