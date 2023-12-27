import 'package:cloud_firestore/cloud_firestore.dart';

class KhachHang {
  final String idKH;
  final String email;
  final int gioiTinh;
  final String hoTen;
  final String matKhau;
  final String ngaySinh;
  final String ngheNghiep;
  final String sdt;

  KhachHang({
    required this.idKH,
    required this.email,
    required this.gioiTinh,
    required this.hoTen,
    required this.matKhau,
    required this.ngaySinh,
    required this.ngheNghiep,
    required this.sdt,
  });

  factory KhachHang.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return KhachHang(
      idKH: data['idKH'],
      email: data['email'] ?? '',
      gioiTinh: data['gioiTinh'] ?? '',
      hoTen: data['hoTen'] ?? '',
      matKhau: data['matKhau'],
      ngaySinh: data['ngaySinh'] ?? '',
      ngheNghiep: data['ngheNghiep'] ?? '',
      sdt: data['sdt'],
    );
  }
}
