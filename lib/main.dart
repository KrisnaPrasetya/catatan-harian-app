import 'package:daily_notes_app/core/base/base_app.dart';
import 'package:daily_notes_app/core/base/base_controller.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await BaseController.initialize();
  runApp(const BaseApp());
}
