import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NotepadDetailController extends GetxController {
  final TextEditingController titleController = TextEditingController(),
      contentController = TextEditingController(); // Untuk konten catatan
  Map<String, dynamic>? notepad;

  String? originalTitle, originalContent;

  @override
  void onInit() {
    super.onInit();
    assignNotepad(); 
  }

  @override
  void onReady() {
    super.onReady();
    assignNotepad(); 
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }

  // Fungsi untuk mengisi notepad dengan data yang diterima
  void assignNotepad() {
    notepad = {
      'title': '',
      'content': '',
    };

    print('notepad $notepad');

    if (notepad != null) {
      titleController.text = notepad!['title'] ?? '';
      contentController.text =
          notepad!['content'] ?? ''; 
      originalTitle = titleController.text;
      originalContent = contentController.text;
    }
  }

  // Fungsi untuk menyimpan catatan baru atau perubahan catatan
  void saveNotepad() {
    if (notepad != null) {
      // Memperbarui judul dan konten notepad dengan input dari pengguna
      notepad!['title'] = titleController.text;
      notepad!['content'] = contentController.text;

      // Kembalikan notepad yang sudah disimpan ke halaman home
      Get.back(result: notepad);
    }
  }

  // Fungsi untuk memeriksa apakah ada perubahan sebelum kembali
  Future<bool> onBackPressed() async {
    // Jika ada perubahan pada judul atau konten
    if (titleController.text != originalTitle ||
        contentController.text != originalContent) {
      bool shouldLeave = await _showExitWithoutSavingDialog();
      return shouldLeave; 
    }
    return true; // Tidak ada perubahan, lanjutkan kembali tanpa dialog
  }

  // Menampilkan dialog untuk mengonfirmasi apakah pengguna ingin keluar tanpa menyimpan
  Future<bool> _showExitWithoutSavingDialog() async {
    return await Get.dialog(
          AlertDialog(
            title: Text('Perubahan belum disimpan'),
            content: Text(
                'Apakah Anda yakin ingin kembali tanpa menyimpan perubahan?'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(result: false); // Batal, jangan kembali
                },
                child: Text('Tidak'),
              ),
              TextButton(
                onPressed: () {
                  Get.back(result: true); // Lanjutkan keluar
                },
                child: Text('Ya'),
              ),
            ],
          ),
        ) ??
        false; // Default false jika dialog ditutup tanpa pilihan
  }
}
