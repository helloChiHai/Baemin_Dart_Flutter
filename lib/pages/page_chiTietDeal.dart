import 'package:baemax/modal/nhaHang.dart';
import 'package:baemax/pages/page_chiTietNhaHang.dart';
import 'package:baemax/widgets/listNhaHang_chiTietNhaHang.dart';
import 'package:baemax/widgets/listNhaHang_danhMucVaCuaHang.dart';
import 'package:baemax/widgets/listNhaHang_sapXep.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/NhaHang.dart';

class chiTietDealPage extends StatefulWidget {
  const chiTietDealPage({super.key});

  @override
  State<chiTietDealPage> createState() => _chiTietDealPageState();
}

class _chiTietDealPageState extends State<chiTietDealPage> {
  final List<nhaHang> NhaHangs = [
    nhaHang(
      idNH: 'NH001',
      tenNH: 'PHÚC LONG',
      diaChiNH: 'Cà MauCà MauCà MauCà MauCà MauCà MauCà MauCà Mau',
      monAn: 'Bánh canh cá lóc',
      khoangCach: 9.0,
      danhGia: 4.5,
    ),
    nhaHang(
      idNH: 'NH002',
      tenNH: 'ĂN VẶT',
      diaChiNH: '299 Tân Kỳ Tân Qúy, Phường Tân Sơn Nhì, Quận Tân Phú, Tp.HCM',
      monAn: 'Bánh canh cá lóc',
      khoangCach: 0.1,
      danhGia: 3.7,
    ),
    nhaHang(
      idNH: 'NH003',
      tenNH: 'CƠM',
      diaChiNH: '299 Tân Kỳ Tân Qúy, Phường Tân Sơn Nhì, Quận Tân Phú, Tp.HCM',
      monAn: 'Bánh canh cá lóc',
      khoangCach: 2.8,
      danhGia: 1.5,
    ),
    nhaHang(
      idNH: 'NH004',
      tenNH: 'TRÀ',
      diaChiNH: '299 Tân Kỳ Tân Qúy, Phường Tân Sơn Nhì, Quận Tân Phú, Tp.HCM',
      monAn: 'Bánh canh cá lóc',
      khoangCach: 9.0,
      danhGia: 0.5,
    ),
    nhaHang(
      idNH: 'NH005',
      tenNH: 'TOCO TOCO',
      diaChiNH: '299 Tân Kỳ Tân Qúy, Phường Tân Sơn Nhì, Quận Tân Phú, Tp.HCM',
      monAn: 'Bánh canh cá lóc',
      khoangCach: 9.0,
      danhGia: 2.2,
    ),
    nhaHang(
      idNH: 'NH006',
      tenNH: 'MÌ',
      diaChiNH: '299 Tân Kỳ Tân Qúy, Phường Tân Sơn Nhì, Quận Tân Phú, Tp.HCM',
      monAn: 'Bánh canh cá lóc',
      khoangCach: 9.0,
      danhGia: 2.5,
    ),
    nhaHang(
      idNH: 'NH007',
      tenNH: 'LẨU',
      diaChiNH: '299 Tân Kỳ Tân Qúy, Phường Tân Sơn Nhì, Quận Tân Phú, Tp.HCM',
      monAn: 'Bánh canh cá lóc',
      khoangCach: 9.0,
      danhGia: 1.0,
    ),
    nhaHang(
      idNH: 'NH008',
      tenNH: 'KATI NAT',
      diaChiNH: '299 Tân Kỳ Tân Qúy, Phường Tân Sơn Nhì, Quận Tân Phú, Tp.HCM',
      monAn: 'Bánh canh cá lóc',
      khoangCach: 9.0,
      danhGia: 5.0,
    ),
  ];

  bool isCheckedKM = false;
  bool isCheckedDMC = false;
  bool isCheckedDT = false;
  String selectedSortStyle = '';
  int soLuongDMCHDuocChon = 0;
  String chonDanhMucCuaHang = '';
  String viTriDanhMucCuaHangDuocCho = '';
  bool sapXep = false;

  void capNhatChonDanhMucCuaHang(String value, String viTri) {
    setState(() {
      chonDanhMucCuaHang += '$value ';
      viTriDanhMucCuaHangDuocCho += '$viTri ';
    });
  }

  void capNhatSoLuongDMCHDuocChon(int soLuongMoi) {
    setState(() {
      soLuongDMCHDuocChon = soLuongMoi;
      if (soLuongDMCHDuocChon == 0) {
        chonDanhMucCuaHang = '';
        viTriDanhMucCuaHangDuocCho = '';
      }
    });
  }

  List<nhaHang> ketQuaTimKiem = [];

  List<nhaHang> timKiemVaSapXepTangDan(
      List<nhaHang> danhSachNhaHang, String kieuSapXep) {
    List<nhaHang> ketQuaTimKiem = danhSachNhaHang
        .where((nhaHang) => chonDanhMucCuaHang
            .trim()
            .toLowerCase()
            .split(' ')
            .any((tukhoa) => nhaHang.tenNH.toLowerCase().contains(tukhoa)))
        .toList();

    if (kieuSapXep == 'Gần nhất') {
      ketQuaTimKiem.sort((a, b) => a.khoangCach.compareTo(b.khoangCach));
    } else if (kieuSapXep == 'Đánh giá tốt') {
      ketQuaTimKiem.sort((a, b) => b.danhGia.compareTo(a.danhGia));
    } else {
      ketQuaTimKiem.sort((a, b) => a.tenNH.compareTo(b.tenNH));
    }

    return ketQuaTimKiem;
  }

  List<QueryDocumentSnapshot>? documents; // Danh sách documents

  @override
  Widget build(BuildContext context) {
    List<nhaHang> ketQuaTimKiem =
        timKiemVaSapXepTangDan(NhaHangs, selectedSortStyle);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Deal đa tầng - khao nước xịn đến 90k',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: const Image(
                image: AssetImage('images/hinh_45.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: 50,
              height: 2,
              color: Colors.grey,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 30,
              ),
              alignment: Alignment.center,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 30,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Tổng hợp quán được áp dụng từ 02 voucher trên một đơn hàng. Giảm đến 90k. Số lượng có hạn.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            // Text('selectedItem: $chonDanhMucCuaHang'),
            // Text('IndexselectedItem: $viTriDanhMucCuaHangDuocCho'),
            Container(
              margin: const EdgeInsets.only(
                top: 15,
              ),
              padding: const EdgeInsets.only(
                left: 10,
              ),
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => sapXepListNhaHang(),
                        ),
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            // selectedSortStyle = value.toString();
                            sapXep = value;
                          });
                        }
                      });
                    },
                    child: Container(
                      width: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 232, 231, 231),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 75,
                            child: Text(
                              selectedSortStyle.isEmpty
                                  ? 'Sắp xếp'
                                  : selectedSortStyle,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 66, 66, 66),
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromARGB(255, 66, 66, 66),
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Lọc',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 66, 66, 66),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => danhMucVaCuaHangListNhaHang(
                            onCheckboxCountChanged: capNhatSoLuongDMCHDuocChon,
                            onItemSelected: capNhatChonDanhMucCuaHang,
                            initialIndexSelectedItem:
                                viTriDanhMucCuaHangDuocCho,
                          ),
                        ),
                      ).then((value) {
                        if (value != null && value is String) {
                          setState(() {
                            viTriDanhMucCuaHangDuocCho = value;
                          });
                        }
                      });
                    },
                    child: Container(
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 232, 231, 231),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            soLuongDMCHDuocChon.toString() == '0'
                                ? 'Danh mục & cửa hàng'
                                : 'Danh mục & cửa hàng ${soLuongDMCHDuocChon.toString()}',
                            // 'Danh mục & cửa hàng ${soLuongDMCHDuocChon.toString()}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 66, 66, 66),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromARGB(255, 66, 66, 66),
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCheckedKM = !isCheckedKM;
                      });
                    },
                    child: Container(
                      width: 130,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 232, 231, 231),
                        ),
                        color: isCheckedKM
                            ? const Color.fromARGB(255, 232, 231, 231)
                            : Colors.transparent,
                      ),
                      child: Text(
                        'Khuyến mãi',
                        style: TextStyle(
                          fontSize: 20,
                          color: isCheckedKM
                              ? Colors.black
                              : const Color.fromARGB(255, 66, 66, 66),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCheckedDMC = !isCheckedDMC;
                      });
                    },
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 232, 231, 231),
                        ),
                        color: isCheckedDMC
                            ? const Color.fromARGB(255, 232, 231, 231)
                            : Colors.transparent,
                      ),
                      child: Text(
                        'Đang mở cửa',
                        style: TextStyle(
                          fontSize: 20,
                          color: isCheckedDMC
                              ? Colors.black
                              : const Color.fromARGB(255, 66, 66, 66),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCheckedDT = !isCheckedDT;
                      });
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 232, 231, 231),
                        ),
                        color: isCheckedDT
                            ? const Color.fromARGB(255, 232, 231, 231)
                            : Colors.transparent,
                      ),
                      child: Text(
                        'Đối tác',
                        style: TextStyle(
                          fontSize: 20,
                          color: isCheckedDT
                              ? Colors.black
                              : const Color.fromARGB(255, 66, 66, 66),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('nhaHang')
                  .orderBy('khoangCach', descending: sapXep)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                // Lấy danh sách documents từ snapshot
                List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    // Lấy dữ liệu của món ăn từ document
                    Map<String, dynamic> foodData =
                        documents[index].data() as Map<String, dynamic>;

                    // Trích xuất tên và giá của món ăn
                    String IDNhaHang = documents![index].id;
                    String tenNH = foodData['tenNH'];
                    String anhDaiDienNH = foodData['anhDaiDienNH'];
                    String diaChiNH = foodData['diaChiNH'];
                    num khoangCach = foodData['khoangCach'];
                    num danhGia = foodData['danhGia'];
                    num SLDaBan = foodData['SLDaBan'];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => chiTietNhaHangPage(
                              IDNhaHang: IDNhaHang,
                              tenNH: tenNH,
                              anhDaiDienNH: anhDaiDienNH,
                              diaChiNH: diaChiNH,
                              khoangCach: khoangCach,
                              danhGia: danhGia,
                              SLDaBan: SLDaBan,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 120,
                              height: 125,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: AssetImage(anhDaiDienNH),
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 105,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 5,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: const Text(
                                        'PROMO',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 220,
                                    child: Row(
                                      children: [
                                        const Image(
                                          image:
                                              AssetImage('images/hinh_78.png'),
                                          width: 25,
                                          height: 25,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          child: Container(
                                            width: 250,
                                            child: Text(
                                              tenNH,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 220,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 27,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '$danhGia ',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' ($SLDaBan+)',
                                                // text: SLDaBan.toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '· $khoangCach km',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color:
                                                Color.fromARGB(255, 72, 72, 72),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
