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
                scrolledUnderElevation: 0,
                title: Text('Catatan'),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: Colors.grey[400],
                centerTitle: true,
                iconTheme: IconThemeData(color: Colors.white),
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
                backgroundColor: Colors.amber[600],
                onPressed: controller.saveNotepad,
                tooltip: 'Simpan Catatan',
                child: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }
}
