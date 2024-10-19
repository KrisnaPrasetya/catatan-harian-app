import 'package:daily_notes_app/modules/auth/login/controller/login_controller.dart';
import 'package:daily_notes_app/modules/auth/register/controller/register_controller.dart';
import 'package:daily_notes_app/modules/home/homepage/controller/homepage_controller.dart';
import 'package:daily_notes_app/modules/home/notepad_detail/controller/notepad_detail_controller.dart';
import 'package:get/get.dart';

class BaseController {
  static initialize() {
    Get.put(LoginController());
    Get.put(RegisterController());
    Get.put(HomePageController());
    Get.put(NotepadDetailController());
  }
}
