import 'package:cloud_firestore/cloud_firestore.dart';

class NhaHang {
  final String? IDNhaHang;
  final String tenNH;
  final String anhDaiDienNH;
  final String diaChiNH;
  final num khoangCach;
  final num danhGia;
  final num SLDaBan;

  NhaHang({
    this.IDNhaHang,
    required this.tenNH,
    required this.anhDaiDienNH,
    required this.diaChiNH,
    required this.khoangCach,
    required this.danhGia,
    required this.SLDaBan,
  });

  factory NhaHang.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) {
      throw Exception('Dữ liệu nhà hàng không tồn tại hoặc không đúng định dạng.');
    }

    return NhaHang(
      IDNhaHang: document.id,
      tenNH: data["tenNH"] as String? ?? '',
      anhDaiDienNH: data["anhDaiDienNH"] as String? ?? '',
      diaChiNH: data["diaChiNH"] as String? ?? '',
      khoangCach: data["khoangCach"] as num? ?? 0,
      danhGia: data["danhGia"] as num? ?? 0,
      SLDaBan: data["SLDaBan"] as num? ?? 0,
    );
  }
}
