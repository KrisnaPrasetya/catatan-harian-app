import 'package:daily_notes_app/modules/auth/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Login'),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: controller.usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Username',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Obx(() => TextField(
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                        obscureText: controller.isPasswordHidden.value,
                      )),
                  SizedBox(height: 20),
                  SizedBox(
                    width: Get.width,
                    child: ElevatedButton(
                      onPressed: controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[700],
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                      width: Get.width,
                      child: ElevatedButton(
                        onPressed: controller.toRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
