import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/homepage_controller.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Home'),
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: controller.logout, // Panggil fungsi logout
                  tooltip: 'Logout',
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Obx(() {
                    if (controller.notepads.isEmpty) {
                      return Center(child: Text('Tidak ada catatan.'));
                    }
                    return Column(
                      children: controller.notepads.map((notepad) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              "Title: ${notepad['title']}",
                              overflow: TextOverflow
                                  .ellipsis, // Menampilkan judul dengan ellipsis jika terlalu panjang
                            ),
                            trailing: ElevatedButton.icon(
                              onPressed: () {
                                controller.editNotepad(notepad);
                              },
                              icon: Icon(Icons.edit),
                              label: Text('Edit'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: controller.addNewNotepad,
              tooltip: 'Tambah Catatan Baru',
              child: Icon(Icons.add),
            ),
          );
        });
  }
}
