class GioHang {
  final String? IDMonAn;
  final String? IDNhaHang;
  final String tenMon;
  final String hinhAnhMA;
  final double giaTien;
  num soLuongMonDuocChon;

  GioHang(
      {this.IDMonAn,
      this.IDNhaHang,
      required this.tenMon,
      required this.hinhAnhMA,
      required this.giaTien,
      this.soLuongMonDuocChon = 1});
}
