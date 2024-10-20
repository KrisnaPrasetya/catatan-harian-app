import 'dart:convert';

import 'package:daily_notes_app/core/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotepadDetailController extends GetxController {
  final TextEditingController titleController = TextEditingController(),
      contentController = TextEditingController();
  Map<String, dynamic>? notepad;
  final LocalStorageService storage = LocalStorageService();

  // Fungsi untuk mengisi data catatan yang akan diedit
  void assignTextController({required String title, required String content}) {
    titleController.text = title;
    contentController.text = content;
    update();
  }

  // Fungsi untuk menambahkan catatan baru
  void _addNotepad(Map<String, dynamic>? notepad) {
    storage.read(key: 'currentUsername').then((currentUsername) {
      // print('currentUsername: $currentUsername');
      if (currentUsername != null) {
        // print('notepads_$currentUsername');
        storage.read(key: 'notepads_$currentUsername').then((storedNotepads) {
          List<Map<String, dynamic>> notepads = [];
          if (storedNotepads != null)
            notepads =
                List<Map<String, dynamic>>.from(jsonDecode(storedNotepads));
          if (notepad != null) {
            int index = notepads.indexWhere((element) => element == notepad);
            if (index != -1) {
              notepads[index] = notepad;
            } else {
              notepads.add(notepad);
            }
            storage.write(
                key: 'notepads_$currentUsername', value: jsonEncode(notepads));
            Get.back(result: true);
          }
        });
      }
    });
  }

  // Fungsi untuk mengedit catatan
  void _editNotepad() {
    storage.read(key: 'currentUsername').then((currentUsername) {
      if (currentUsername != null) {
        storage.read(key: 'notepads_$currentUsername').then((storedNotepads) {
          List<Map<String, dynamic>> notepads = [];
          if (storedNotepads != null)
            notepads =
                List<Map<String, dynamic>>.from(jsonDecode(storedNotepads));
          if (notepad != null) {
            final int indexEdit = Get.arguments['index_edit'] =
                Get.arguments['index_edit'] as int;
            notepads[indexEdit] = notepad!;
            storage.write(
                key: 'notepads_$currentUsername', value: jsonEncode(notepads));
            Get.back(result: true);
          }
        });
      }
    });
  }

  // Fungsi untuk menyimpan catatan baru atau perubahan catatan
  void saveNotepad() async {
    if (titleController.text == '' || contentController.text == '') {
      Get.snackbar(
        'Gagal Menyimpan',
        'Judul dan konten tidak boleh kosong',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
      return;
    }
    notepad = {
      'title': titleController.text,
      'content': contentController.text,
    };
    print('notepad: $notepad');
    Get.arguments['action'] == 'edit' ? _editNotepad() : _addNotepad(notepad);
  }

  // Fungsi untuk memeriksa apakah ada perubahan sebelum kembali
  Future<bool> onBackPressed() async {
    // Jika ada perubahan pada judul atau konten
    if (titleController.text != '' || contentController.text != '') {
      bool shouldLeave = await _showExitWithoutSavingDialog();
      return shouldLeave;
    }
    return true;
  }

  // Menampilkan dialog untuk mengonfirmasi apakah pengguna ingin keluar tanpa menyimpan
  Future<bool> _showExitWithoutSavingDialog() async {
    return await Get.dialog(
          Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning_amber_rounded,
                      size: 48, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Perubahan belum disimpan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Apakah Anda yakin ingin kembali tanpa menyimpan perubahan?',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: Get.width * 0.3,
                        child: ElevatedButton(
                          onPressed: () => Get.back(result: false),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                          child: Text('Tidak',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.3,
                        child: ElevatedButton(
                          onPressed: () => Get.back(result: true),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child:
                              Text('Ya', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ) ??
        false;
  }
}
