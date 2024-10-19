import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/notepad_detail_controller.dart';

class NotepadDetailScreen extends StatelessWidget {
  const NotepadDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotepadDetailController>(
        init: NotepadDetailController(),
        builder: (controller) {
          return WillPopScope(
            // Untuk menangani event ketika pengguna menekan tombol back
            onWillPop: controller.onBackPressed,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Tambah/Edit Catatan'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Input untuk judul catatan
                    TextField(
                      controller: controller.titleController,
                      decoration: InputDecoration(labelText: 'Judul Catatan'),
                    ),
                    SizedBox(height: 20),
                    // Input untuk konten catatan
                    Expanded(
                      child: TextField(
                        controller: controller.contentController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration:
                            InputDecoration(labelText: 'Konten Catatan'),
                      ),
                    ),
                  ],
                ),
              ),
              // Tombol Simpan yang mengambang di kanan bawah
              floatingActionButton: FloatingActionButton(
                onPressed: controller
                    .saveNotepad, // Memanggil fungsi saveNotepad untuk menyimpan catatan
                tooltip: 'Simpan Catatan',
                child: Icon(Icons.save),
              ),
            ),
          );
        });
  }
}
