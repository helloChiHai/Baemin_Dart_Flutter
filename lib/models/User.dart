import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  String phoneNumber = '';
  String password = '';
  bool trangThaiDangNhap = false;

  void updateInfo(String newPhoneNumber, String newPassword) {
    phoneNumber = newPhoneNumber;
    password = newPassword;
    trangThaiDangNhap = true; // Đăng nhập thành công
    notifyListeners();
  }

  void clearInfo() {
    phoneNumber = '';
    password = '';
    trangThaiDangNhap = false; // Đăng nhập thất bại
    notifyListeners();
  }
}
