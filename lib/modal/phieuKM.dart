class PhieuKM {
  final String id_phieuKM;
  final String ten_phieuKM;
  final DateTime HSD_phieuKM;
  final List<String> noiDung_phieuKM;

  PhieuKM(
      {required this.id_phieuKM,
      required this.ten_phieuKM,
      required this.HSD_phieuKM,
      required this.noiDung_phieuKM});
}


// void main() {
//   // Tạo một đối tượng PhieuKM
//   PhieuKM phieuKM = PhieuKM(
//     "123",
//     "Phiếu khuyến mãi XYZ",
//     ["Nội dung 1", "Nội dung 2"],
//   );

//   // In thông tin của đối tượng PhieuKM
//   print("ID: ${phieuKM.id_phieuKM}");
//   print("Tên: ${phieuKM.ten_phieuKM}");
//   print("Nội dung:");
//   for (String noiDung in phieuKM.noiDungKM) {
//     print("- $noiDung");
//   }
// }