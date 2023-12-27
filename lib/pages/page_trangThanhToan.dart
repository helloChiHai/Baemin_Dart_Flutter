import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../widgets/chiTietIemNhaHangDuocApDung.dart';

class trangThanhToanPage extends StatefulWidget {
  final String IDCuaKhachHang;
  final String IDCuaNhaHang;
  trangThanhToanPage(
      {Key? key, required this.IDCuaKhachHang, required this.IDCuaNhaHang})
      : super(key: key);

  @override
  State<trangThanhToanPage> createState() => _trangThanhToanPageState();
}

class _trangThanhToanPageState extends State<trangThanhToanPage> {
  int _secondsRemaining = 1 * 60; // 5 minutes
  bool _isWidgetDisposed = false;

  bool xacNhanDatHang = false;

  late Timer _timer;

  String idKhachHang = '';
  String idNhaHang = '';
  int tongSoLuongMon = 0;
  num khoangCachNH = 0;
  num tienTamTinh = 0;
  num tienGiamGiaSuKienToanServer = 4.000;

  @override
  void initState() {
    super.initState();
    startTimer();
    setState(() {
      idKhachHang = widget.IDCuaKhachHang ?? '';
      idNhaHang = widget.IDCuaNhaHang ?? '';
    });
  }

  @override
  void dispose() {
    _isWidgetDisposed = true;
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_isWidgetDisposed) return; // Kiểm tra widget đã bị loại bỏ chưa
      setState(() {
        if (_secondsRemaining < 1) {
          _timer.cancel();
          // Do something when countdown finishes
        } else {
          _secondsRemaining--;
        }
      });
    });
  }

  String formatTime(int seconds) {
    int hours = (seconds / 3600).floor();
    int minutes = ((seconds % 3600) / 60).floor();
    int remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  double tongTien = 0;
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
          'Trang thanh toán',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          size: 30,
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: const Color.fromARGB(255, 227, 226, 226),
            child: Column(
              children: [
                Container(
                  height: 600,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 191, 214, 233),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Image(
                                  image: AssetImage('images/hinh_81.png'),
                                ),
                              ),
                              Container(
                                width: 315,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Giao bởi tài xế',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Ktx',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Icon(Icons.arrow_outward_outlined)
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 280,
                                      child: const Text(
                                        'Kí túc xá trường đại học Công Thương TP.HCM',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Đơn hàng của bạn',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('khachHang')
                                      .doc(idKhachHang)
                                      .collection('gioHang')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final gioHangDocs = snapshot.data!.docs;
                                      return Column(
                                        children: gioHangDocs.map((doc) {
                                          final data = doc.data()
                                              as Map<String, dynamic>;
                                          final tenMon =
                                              data['tenMon'] as String;
                                          int soLuong =
                                              data['soLuongMonDuocChon'] as int;
                                          final giaMon =
                                              data['giaTien'] as double;

                                          return Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 20,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '$soLuong x',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: 230,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        tenMon,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const Text(
                                                        'Trụng sẵn',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          NumberFormat("0.000")
                                                              .format(giaMon),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            // Xóa món ăn và cập nhật Firestore
                                                            doc.reference
                                                                .delete()
                                                                .then((_) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          'Xóa món ăn thành công');
                                                            }).catchError(
                                                                    (error) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          'Lỗi khi xóa món ăn: $error');
                                                            });
                                                          },
                                                          icon: const Icon(
                                                            Icons.close,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Text('Đã xảy ra lỗi');
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => itemChiTietNhaHangDuocApDung(item: 'item'),
                                  //   ),
                                  // );
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  '+ Thêm món',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
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
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('khachHang')
                                          .doc(idKhachHang)
                                          .collection('gioHang')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final gioHangDocs =
                                              snapshot.data!.docs;
                                          tinhTongSoLuongVaTien(gioHangDocs);

                                          return Text(
                                            'Tạm tính ($tongSoLuongMon món)',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
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
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('khachHang')
                                          .doc(idKhachHang)
                                          .collection('gioHang')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final gioHangDocs =
                                              snapshot.data!.docs;
                                          tinhTongSoLuongVaTien(gioHangDocs);
                                          tienTamTinh = tongTien;

                                          return Text(
                                            '${NumberFormat("0.000").format(tongTien)}đ',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
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
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('nhaHang')
                                            .doc(idNhaHang)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.data!.exists) {
                                            final restaurantData =
                                                snapshot.data!.data()
                                                    as Map<String, dynamic>;

                                            if (restaurantData
                                                .containsKey('khoangCach')) {
                                              final khoangCach =
                                                  restaurantData['khoangCach']
                                                      as num;

                                              khoangCachNH = khoangCach;
                                              // Gán địa chỉ vào Text widget
                                              return RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text: 'Phí áp dụng: ',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: '${khoangCach}km',
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return const Text(
                                                  'Trường dữ liệu "diaChi" không tồn tại');
                                            }
                                          } else if (snapshot.hasError) {
                                            return Text('Đã xảy ra lỗi');
                                          } else {
                                            return CircularProgressIndicator();
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      '${NumberFormat("0.000").format(khoangCachNH * 5.000)}đ',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 3),
                                alignment: Alignment.centerLeft,
                                child: Transform(
                                  transform: Matrix4.skewX(
                                      -0.3), // Điều chỉnh độ nghiêng theo trục X (tùy chỉnh giá trị tại đây)
                                  child: const Text(
                                    '(Với 1km là 5.000đ)',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Mùa hè sôi động, khao',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      '- ${NumberFormat("0.000").format(tienGiamGiaSuKienToanServer)}đ',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.red,
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
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image(
                                        image: AssetImage('images/hinh_19.png'),
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Tiền mặt',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2,
                                height: 45,
                                child: Container(
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    print('chuyển sang page coupons');
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'THÊM COUPON',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        NumberFormat("0.000").format(
                                            ((khoangCachNH * 5.000) +
                                                tienTamTinh)),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        NumberFormat("0.000").format(
                                            (((khoangCachNH * 5.000) +
                                                    tienTamTinh)) -
                                                tienGiamGiaSuKienToanServer),
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    xacNhanDatHang = true;
                                  });
                                  print('${widget.IDCuaNhaHang}');
                                },
                                child: Container(
                                  width: 245,
                                  height: 70,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Đặt hàng',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: xacNhanDatHang,
            maintainSize: false,
            maintainState: true,
            maintainAnimation: true,
            child: Container(
              alignment: Alignment.center,
              color: Colors.grey.withOpacity(0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Bạn đợi xíu nha',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Shipper đang giao cho bạn nè',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                formatTime(_secondsRemaining),
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Image(
                                image: AssetImage('images/hinh_81.png'),
                                width: 40,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          xacNhanDatHang = false;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
