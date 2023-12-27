import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'page_trangThanhToan.dart';

class gioHangPage extends StatefulWidget {
  final String IDCuaKhachHang;
  final String IDCuaNhaHang;
  gioHangPage(
      {Key? key, required this.IDCuaKhachHang, required this.IDCuaNhaHang})
      : super(key: key);

  @override
  State<gioHangPage> createState() => _gioHangPageState();
}

class _gioHangPageState extends State<gioHangPage> {
  int thayDoiSoLuong = 1;
  TextEditingController thayDoiSoLuongController = TextEditingController();
  double tongTien = 0;
  int tongSoLuongMon = 0;
  bool kiemTraSoLuongThayDoi = false;
  String idKhachHang = '';
  String idNhaHang = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      idKhachHang = widget.IDCuaKhachHang ?? '';
      idNhaHang = widget.IDCuaNhaHang ?? '';
    });

    thayDoiSoLuongController.text = thayDoiSoLuong.toString();
    thayDoiSoLuongController.addListener(capNhatSoLuong);
    initTongTienVaSoLuong();
  }

  void initTongTienVaSoLuong() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('khachHang')
        .doc(idKhachHang)
        .collection('gioHang')
        .get();

    final gioHangDocs = snapshot.docs;
    tinhTongSoLuongVaTien(gioHangDocs);
  }

  void capNhatSoLuong() {
    setState(() {
      thayDoiSoLuong = int.parse(thayDoiSoLuongController.text);
    });
  }

  void xoaTatCaMonAn() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('khachHang')
        .doc(idKhachHang)
        .collection('gioHang')
        .get();

    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
    print('Đã xóa tất cả các món trong giỏ hàng');
  }

  void tinhTongSoLuongVaTien(List<QueryDocumentSnapshot> gioHangDocs) {
    tongTien = 0;
    tongSoLuongMon = 0;

    for (var doc in gioHangDocs) {
      final data = doc.data() as Map<String, dynamic>;
      int soLuong = data['soLuongMonDuocChon'] as int;
      final giaMon = data['giaTien'] as double;

      tongSoLuongMon += soLuong;
      tongTien += giaMon * soLuong;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              xoaTatCaMonAn();
            },
            child: const Text(
              'Xóa',
              style: TextStyle(
                  fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Container(
              height: 675,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('khachHang')
                    .doc(idKhachHang)
                    .collection('gioHang')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final gioHangDocs = snapshot.data!.docs;

                    tinhTongSoLuongVaTien(gioHangDocs);
                    return SingleChildScrollView(
                      child: Column(
                        children: gioHangDocs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          final tenMon = data['tenMon'] as String;
                          int soLuong = data['soLuongMonDuocChon'] as int;
                          final giaMon = data['giaTien'] as double;

                          TextEditingController soLuongController =
                              TextEditingController(text: soLuong.toString());

                          void updateSoLuongMon() async {
                            try {
                              await doc.reference
                                  .update({'soLuongMonDuocChon': soLuong});
                              print('Cập nhật số lượng món thành công');
                            } catch (e) {
                              print('Lỗi khi cập nhật số lượng món: $e');
                            }
                          }

                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    tenMon,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: double.infinity,
                                  child: const Text(
                                    'Trụng sẵn',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      NumberFormat("0.000").format(giaMon),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: soLuong < 2
                                                  ? const Color.fromARGB(
                                                      255, 238, 238, 238)
                                                  : const Color.fromARGB(
                                                      255, 224, 224, 224),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: TextButton(
                                              onPressed: soLuong < 2
                                                  ? null
                                                  : () {
                                                      setState(() {
                                                        soLuong--;
                                                        soLuongController.text =
                                                            soLuong.toString();
                                                      });
                                                      updateSoLuongMon();
                                                    },
                                              child: const Text(
                                                '-',
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Container(
                                            width: 30,
                                            child: TextFormField(
                                              controller: soLuongController,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                setState(() {
                                                  soLuong =
                                                      int.tryParse(value) ??
                                                          soLuong;
                                                });
                                              },
                                              onEditingComplete: () {
                                                updateSoLuongMon();
                                              },
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 224, 224, 224),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  soLuong++;
                                                  soLuongController.text =
                                                      soLuong.toString();
                                                });
                                                updateSoLuongMon();
                                              },
                                              child: const Text(
                                                '+',
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Đã xảy ra lỗi');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          trangThanhToanPage(IDCuaKhachHang: idKhachHang, IDCuaNhaHang: idNhaHang),
                    ),
                  );
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('khachHang')
                              .doc(idKhachHang)
                              .collection('gioHang')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final gioHangDocs = snapshot.data!.docs;
                              tinhTongSoLuongVaTien(gioHangDocs);

                              return Text(
                                tongSoLuongMon.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else {
                              return const Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          },
                        ),
                        const Text(
                          'Trang thanh toán',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('khachHang')
                              .doc(idKhachHang)
                              .collection('gioHang')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final gioHangDocs = snapshot.data!.docs;
                              tinhTongSoLuongVaTien(gioHangDocs);

                              return Text(
                                NumberFormat("0.000").format(tongTien),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else {
                              return const Text(
                                '0.000',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
