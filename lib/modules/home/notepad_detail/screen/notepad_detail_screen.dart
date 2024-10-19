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
                      decoration: InputDecoration(
                        hintText: 'Judul Catatan',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold, // Mengatur gaya teks yang diketik
                      ),
                    ),
                    SizedBox(height: 20),
                    // Input untuk konten catatan
                    Expanded(
                      child: TextField(
                        controller: controller.contentController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Konten Catatan',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Tombol Simpan yang mengambang di kanan bawah
              floatingActionButton: FloatingActionButton(
                onPressed: controller.saveNotepad,
                tooltip: 'Simpan Catatan',
                child: Icon(Icons.save),
              ),
            ),
          );
        });
  }
}
