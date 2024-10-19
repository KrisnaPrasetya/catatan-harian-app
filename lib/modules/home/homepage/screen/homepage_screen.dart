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
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              title: Text('Catatan Saya'),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.grey[400],
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: controller.logout,
                  tooltip: 'Logout',
                  color: Colors.white,
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
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () => controller.editNotepad(
                                        notepad),
                                    tooltip: 'Edit',
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => controller.deleteNotepad(
                                        notepad),
                                    tooltip: 'Delete',
                                  ),
                                ),
                              ],
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
              backgroundColor: Colors.amber[600],
              onPressed: controller.addNewNotepad,
              tooltip: 'Tambah Catatan Baru',
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        });
  }
}
