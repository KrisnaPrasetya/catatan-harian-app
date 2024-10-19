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
                      onChanged: (value) => controller.update,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: TextField(
                        controller: controller.contentController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) => controller.update,
                        decoration: InputDecoration(
                          hintText: 'Konten Catatan',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
