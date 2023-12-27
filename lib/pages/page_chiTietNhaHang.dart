import 'dart:async';

import 'package:baemax/modal/monAn.dart';
import 'package:baemax/models/MonAn.dart';
import 'package:baemax/pages/page_chiTietCuaMonAn.dart';
import 'package:baemax/pages/page_dangNhap.dart';
import 'package:baemax/pages/page_gioHang.dart';
import 'package:baemax/pages/page_trangThanhToan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tiengviet/tiengviet.dart';

import '../models/User.dart';

class chiTietNhaHangPage extends StatefulWidget {
  final String? IDNhaHang;
  final String tenNH;
  final String anhDaiDienNH;
  final String diaChiNH;
  final num khoangCach;
  final num danhGia;
  final num SLDaBan;

  chiTietNhaHangPage({
    this.IDNhaHang,
    required this.tenNH,
    required this.anhDaiDienNH,
    required this.diaChiNH,
    required this.khoangCach,
    required this.danhGia,
    required this.SLDaBan,
  });

  @override
  State<chiTietNhaHangPage> createState() => _chiTietNhaHangPageState();
}

class _chiTietNhaHangPageState extends State<chiTietNhaHangPage> {
  late ScrollController scrollController;
  late bool showAppBar;
  bool showAppBarDanhMucLoaiMonAn = false;
  late Color iconColor;
  double khoangCachTruocKhiAnAppBarDM = 25;
  bool isContainerVisiable = false;
  late bool checkedHeart;
  int soLuong = 0;
  late String idMonVuaDuocThem;
  List<MonAn> monAnList = [];

  void layMonAnTuNhaHang(String? IDNhaHang) {
    FirebaseFirestore.instance
        .collection('nhaHang')
        .doc(IDNhaHang)
        .collection('monAn')
        .get()
        .then((querySnapshot) {
      if (querySnapshot != null) {
        List<MonAn> fetchedMonAnList = [];
        querySnapshot.docs.forEach((document) {
          MonAn monAn = MonAn(
            IDMonAn: document.id,
            tenMon: document['tenMon'],
            hinhAnhMA: document['hinhAnhMA'],
            giaTien: document['giaTien'].toDouble(),
          );
          fetchedMonAnList.add(monAn);
        });
        setState(() {
          monAnList = fetchedMonAnList;
        });
      } else {
        print('Không có dữ liệu món ăn');
      }
    }).catchError((error) {
      print('Lỗi khi truy vấn món ăn: $error');
    });
  }

  void hienThiContainerTimKiem() {
    setState(() {
      isContainerVisiable = true;
    });
  }

  double tongTienMonAnTrongGioHang = 0;

  String? idUser;

  int soLuongMonAnTrongGioHang = 0;

  Future<int> demSoLuongMonAnTrongGio() async {
    int calculatedTotalQuantity = 0;
    Stream<QuerySnapshot> cartStream = FirebaseFirestore.instance
        .collection('khachHang')
        .doc(idUser)
        .collection('gioHang')
        .snapshots();
    cartStream.listen(
      (QuerySnapshot snapshot) {
        int slReset = 0;
        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          final soLuong = data['soLuongMonDuocChon'] as int;
          slReset += soLuong;
        }
        if (mounted) {
          setState(() {
            soLuongMonAnTrongGioHang = slReset;
            calculatedTotalQuantity = slReset;
          });
        }
      },
    );
    return calculatedTotalQuantity;
  }

  Future<double> tongTienTrongGio() async {
    double tong = 0;
    Stream<QuerySnapshot> cartStream = FirebaseFirestore.instance
        .collection('khachHang')
        .doc(idUser)
        .collection('gioHang')
        .snapshots();
    cartStream.listen((QuerySnapshot snapshot) {
      double tongTien = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final giaMon = data['giaTien'] as double;
        final soLuong = data['soLuongMonDuocChon'] as int;
        tongTien += giaMon * soLuong;
      }
      if (mounted) {
        setState(() {
          tongTienMonAnTrongGioHang = tongTien;
          tong = tongTien;
        });
      }
    });
    return tong;
  }

  List<Map<String, dynamic>> searchResult = [];

  void timKiemMonAnTrongNhaHang(String query) async {
    final uppercaseQuery = TiengViet.parse(query).toUpperCase();

    final result = await FirebaseFirestore.instance
        .collection('nhaHang')
        .doc(widget.IDNhaHang)
        .collection('monAn')
        .orderBy('tenMon')
        .startAt([uppercaseQuery]).get();

    setState(() {
      searchResult = result.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    showAppBar = true;
    iconColor = Colors.white;
    checkedHeart = false;

    khachHangCollection = firestore.collection('khachHang');
    nhaHangCollection = firestore.collection('nhaHang');

    scrollController.addListener(() {
      if (scrollController.offset > 0 &&
          scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        setState(() {
          showAppBar = false;
          iconColor = Colors.black;
        });
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          showAppBar = true;
          iconColor = Colors.white;
        });
      }
      if (scrollController.offset > khoangCachTruocKhiAnAppBarDM &&
          !scrollController.position.outOfRange) {
        setState(() {
          showAppBarDanhMucLoaiMonAn = true;
        });
      } else {
        setState(() {
          showAppBarDanhMucLoaiMonAn = false;
        });
      }
    });

    layMonAnTuNhaHang(widget.IDNhaHang);

    printSL();
    // demSoLuongMonAnTrongGio();
    //  tongTienTrongGio();
  }

  void printSL() async {
    int sl = await demSoLuongMonAnTrongGio();
    double tongTien = await tongTienTrongGio();
    print('$sl');
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference khachHangCollection;
  late CollectionReference nhaHangCollection;

  @override
  void dispose() {
    scrollController.dispose();
    soLuongMonAnTrongGioHang = 0;
    // Thực hiện cập nhật lên Firestore khi thoát widget
    khachHangCollection.get().then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.update({'nhaHang': FieldValue.delete()});
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String phoneNumber = user.phoneNumber;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: Color.fromARGB(255, 225, 225, 225),
                  child: Column(
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 300,
                                    child: Image(
                                      image: AssetImage(widget.anhDaiDienNH),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 230,
                              left: 10.0,
                              right: 10.0,
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xffDDDDDD),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 15,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 3,
                                        vertical: 3,
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'images/hinh_78.png'),
                                            width: 27,
                                            height: 27,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'ĐỐI TÁC CỦA BEAMAX',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      widget.tenNH,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: 300,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              // width: 140,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                '${widget.khoangCach}km',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: 150,
                                              child: Text(
                                                widget.diaChiNH,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 110, 109, 109),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: const Row(
                                    children: [
                                      Image(
                                        image: AssetImage('images/hinh_19.png'),
                                        width: 30,
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Giao bởi tài xế',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  'Thay đổi',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage('images/hinh_28.png'),
                                        width: 30,
                                        height: 30,
                                        color: Colors.yellow,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${widget.danhGia}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '(${widget.SLDaBan}+)',
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage('images/hinh_79.png'),
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${widget.SLDaBan}+ đã bán',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  'Xem đánh giá',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
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
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Nhất định phải thử',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image(
                                  image: AssetImage('images/hinh_19.png'),
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 230,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: monAnList.length,
                                  itemBuilder: (context, index) {
                                    MonAn monAn = monAnList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                chiTietCuaMonAnPage(
                                              IDNhaHang: widget.IDNhaHang,
                                              IDMonAn: monAn.IDMonAn,
                                              tenMon: monAn.tenMon,
                                              hinhAnhMA: monAn.hinhAnhMA,
                                              giaTien: monAn.giaTien,
                                            ),
                                          ),
                                        ).then((value) {
                                          if (value != null &&
                                              value is List<dynamic> &&
                                              value.length == 3) {
                                            setState(() {
                                              soLuong = value[0];
                                              idMonVuaDuocThem = value[1];
                                              idUser = value[2];
                                            });
                                            print(
                                                'sl: $soLuong - ID USER: $idUser');
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 180,
                                        margin: const EdgeInsets.only(
                                          right: 20,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image(
                                                image:
                                                    AssetImage(monAn.hinhAnhMA),
                                                fit: BoxFit.cover,
                                                width: 180,
                                                height: 150,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 180,
                                                    child: Text(
                                                      monAn.tenMon,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                      ),
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 180,
                                                    child: Text(
                                                      '${NumberFormat("0.000").format(monAn.giaTien)}đ',
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                      ),
                                                      softWrap: true,
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Tất cả các món',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image(
                                  image: AssetImage('images/hinh_8.png'),
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('nhaHang')
                                  .doc(widget.IDNhaHang)
                                  .collection('monAn')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                }

                                // Lấy danh sách documents từ snapshot
                                List<QueryDocumentSnapshot> documents =
                                    snapshot.data!.docs;

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: documents.length,
                                  itemBuilder: (context, index) {
                                    // Lấy dữ liệu của món ăn từ document
                                    Map<String, dynamic> foodData =
                                        documents[index].data()
                                            as Map<String, dynamic>;

                                    // Trích xuất tên và giá của món ăn
                                    String idMon = foodData['IDMonAn'];
                                    String tenMon = foodData['tenMon'];
                                    String hinhAnhMon = foodData['hinhAnhMA'];
                                    num giaTien = foodData['giaTien'];

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                chiTietCuaMonAnPage(
                                              IDNhaHang: widget.IDNhaHang,
                                              IDMonAn: idMon,
                                              tenMon: tenMon,
                                              hinhAnhMA: hinhAnhMon,
                                              giaTien: giaTien,
                                            ),
                                          ),
                                        ).then((value) {
                                          if (value != null &&
                                              value is List<dynamic> &&
                                              value.length == 3) {
                                            setState(() {
                                              soLuong = value[0];
                                              idMonVuaDuocThem = value[1];
                                              idUser = value[2];
                                            });
                                            print(
                                                'sl: $soLuong - ID USER: $idUser');
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 180,
                                        margin: const EdgeInsets.only(
                                          bottom: 30,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 150,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 180,
                                                    child: Text(
                                                      tenMon,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                      ),
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 180,
                                                    child: Text(
                                                      '${NumberFormat("0.000").format(giaTien)}đ',
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                      ),
                                                      softWrap: true,
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image(
                                                image: AssetImage(hinhAnhMon),
                                                fit: BoxFit.cover,
                                                width: 180,
                                                height: 150,
                                              ),
                                            ),
                                            // const SizedBox(
                                            //   height: 10,
                                            // ),
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 135,
            child: Column(
              children: [
                //appabr + icon
                Container(
                  height: 80,
                  color: !showAppBarDanhMucLoaiMonAn
                      ? Colors.transparent
                      : Colors.white,
                  padding: const EdgeInsets.only(
                    top: 20,
                    right: 10,
                    left: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape
                                .circle, // Đặt hình dạng thành hình tròn
                            color: !showAppBarDanhMucLoaiMonAn
                                ? Color.fromARGB(255, 101, 101, 101)
                                : Colors.transparent,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: !showAppBarDanhMucLoaiMonAn
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      !showAppBarDanhMucLoaiMonAn
                          ? AnimatedOpacity(
                              opacity: 1,
                              duration: const Duration(milliseconds: 400),
                              child: Container(
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print('đã nhấn tìm kiếm');
                                        hienThiContainerTimKiem();
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Đặt hình dạng thành hình tròn
                                          color: Color.fromARGB(
                                              255, 101, 101, 101),
                                        ),
                                        child: Icon(
                                          Icons.search,
                                          color: iconColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        print('đã nhấn tym');
                                        setState(() {
                                          checkedHeart = !checkedHeart;
                                        });
                                        print('${widget.IDNhaHang}');
                                        if (checkedHeart) {
                                          FirebaseFirestore.instance
                                              .collection('khachHang')
                                              .where('sdt',
                                                  isEqualTo: phoneNumber)
                                              .get()
                                              .then((QuerySnapshot snapshot) {
                                            if (snapshot.size > 0) {
                                              String khachHangId = snapshot
                                                  .docs[0]
                                                  .id; // Lấy ID của tài liệu KhachHang
                                              List<dynamic> nhaHangIds =
                                                  (snapshot.docs[0].data()
                                                              as Map<String,
                                                                  dynamic>)[
                                                          'nhaHangIds'] ??
                                                      [];

                                              if (!nhaHangIds
                                                  .contains(widget.IDNhaHang)) {
                                                // Nếu ID nhà hàng chưa tồn tại trong danh sách
                                                nhaHangIds.add(widget
                                                    .IDNhaHang); // Thêm ID nhà hàng vào danh sách

                                                // Cập nhật tài liệu KhachHang với danh sách mới
                                                FirebaseFirestore.instance
                                                    .collection('khachHang')
                                                    .doc(khachHangId)
                                                    .update({
                                                  'nhaHangIds': nhaHangIds
                                                }).then((value) {
                                                  print(
                                                      'Thêm ID nhà hàng thành công vào KhachHang $khachHangId');
                                                }).catchError((onError) {
                                                  print(
                                                      'Thêm ID nhà hàng không thành công vào KhachHang $onError');
                                                });
                                              } else {
                                                print(
                                                    'ID nhà hàng đã tồn tại trong KhachHang $khachHangId');
                                              }
                                            } else {
                                              print(
                                                  'Không tìm thấy tài liệu KhachHang với số điện thoại $phoneNumber');
                                            }
                                          }).catchError((onError) {
                                            print(
                                                'Lỗi khi tìm tài liệu KhachHang: $onError');
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Đặt hình dạng thành hình tròn
                                          color: Color.fromARGB(
                                              255, 101, 101, 101),
                                        ),
                                        child: Icon(
                                          checkedHeart
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: checkedHeart
                                              ? Colors.red
                                              : iconColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('$soLuongMonAnTrongGioHang');
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Đặt hình dạng thành hình tròn
                                          color: Color.fromARGB(
                                              255, 101, 101, 101),
                                        ),
                                        child: Icon(
                                          Icons.share,
                                          color: iconColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : AnimatedOpacity(
                              opacity: 1,
                              duration: const Duration(milliseconds: 400),
                              child: Container(
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print('đã nhấn tìm kiếm');
                                        hienThiContainerTimKiem();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 245, 235, 235),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.search,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 238,
                                              child: Text(
                                                '${widget.tenNH} - ${widget.diaChiNH}',
                                                // '${widget.item.tenNH}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
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
                                        print('đã nhấn tym');
                                        setState(() {
                                          checkedHeart = !checkedHeart;
                                        });
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Đặt hình dạng thành hình tròn
                                          color: Colors.transparent,
                                        ),
                                        child: Icon(
                                          checkedHeart
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: checkedHeart
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                // appbar + search
                // Expanded(
                //   child: AnimatedOpacity(
                //     opacity: showAppBarDanhMucLoaiMonAn ? 1.0 : 0.0,
                //     duration: const Duration(milliseconds: 300),
                //     child: Container(
                //       padding: const EdgeInsets.symmetric(
                //         vertical: 8,
                //       ),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.black.withOpacity(0.2),
                //             blurRadius: 5, // làm mềm
                //             spreadRadius: 0, // mở rộng
                //             offset: const Offset(
                //               0, // di chuyển sang phải theo chiều ngang
                //               5.0, // dieu chuyển xuống dưới theo chiều dọc
                //             ),
                //           ),
                //         ],
                //       ),
                //       child: ListView(
                //         scrollDirection: Axis.horizontal,
                //         children: [
                //           GestureDetector(
                //             onTap: () {},
                //             child: Container(
                //               height: 55,
                //               alignment: Alignment.center,
                //               padding: const EdgeInsets.symmetric(
                //                 vertical: 5,
                //                 horizontal: 15,
                //               ),
                //               decoration: BoxDecoration(
                //                 color: Color.fromARGB(255, 163, 240, 225),
                //                 borderRadius: BorderRadius.circular(20),
                //               ),
                //               child: Text(
                //                 'Món hot',
                //                 style: TextStyle(
                //                   fontSize: 20,
                //                   color: Color.fromARGB(255, 1, 106, 78),
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //           GestureDetector(
                //             child: Container(
                //               height: 55,
                //               alignment: Alignment.center,
                //               padding: const EdgeInsets.symmetric(
                //                 vertical: 5,
                //                 horizontal: 15,
                //               ),
                //               decoration: BoxDecoration(
                //                 color: Colors.transparent,
                //                 borderRadius: BorderRadius.circular(20),
                //               ),
                //               child: const Text(
                //                 'Milk tea',
                //                 style: TextStyle(
                //                   fontSize: 20,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //           GestureDetector(
                //             child: Container(
                //               height: 55,
                //               alignment: Alignment.center,
                //               padding: const EdgeInsets.symmetric(
                //                 vertical: 5,
                //                 horizontal: 15,
                //               ),
                //               decoration: BoxDecoration(
                //                 color: Colors.transparent,
                //                 borderRadius: BorderRadius.circular(20),
                //               ),
                //               child: const Text(
                //                 'Milk',
                //                 style: TextStyle(
                //                   fontSize: 20,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //           GestureDetector(
                //             child: Container(
                //               height: 55,
                //               alignment: Alignment.center,
                //               padding: const EdgeInsets.symmetric(
                //                 vertical: 5,
                //                 horizontal: 15,
                //               ),
                //               decoration: BoxDecoration(
                //                 color: Colors.transparent,
                //                 borderRadius: BorderRadius.circular(20),
                //               ),
                //               child: const Text(
                //                 'Tea',
                //                 style: TextStyle(
                //                   fontSize: 20,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //           GestureDetector(
                //             child: Container(
                //               height: 55,
                //               alignment: Alignment.center,
                //               padding: const EdgeInsets.symmetric(
                //                 vertical: 5,
                //                 horizontal: 15,
                //               ),
                //               decoration: BoxDecoration(
                //                 color: Colors.transparent,
                //                 borderRadius: BorderRadius.circular(20),
                //               ),
                //               child: const Text(
                //                 'Special drinks',
                //                 style: TextStyle(
                //                   fontSize: 20,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //           GestureDetector(
                //             child: Container(
                //               height: 55,
                //               alignment: Alignment.center,
                //               padding: const EdgeInsets.symmetric(
                //                 vertical: 5,
                //                 horizontal: 15,
                //               ),
                //               decoration: BoxDecoration(
                //                 color: Colors.transparent,
                //                 borderRadius: BorderRadius.circular(20),
                //               ),
                //               child: const Text(
                //                 'Soda',
                //                 style: TextStyle(
                //                   fontSize: 20,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          // search
          isContainerVisiable
              ? Container(
                  height: double.infinity,
                  color: Colors.grey.withOpacity(0.3),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              child: const Icon(
                                Icons.search,
                              ),
                            ),
                            Container(
                              width: 300,
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Tìm trong thực đơn',
                                  hintStyle: TextStyle(
                                    fontSize: 19,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                onChanged: (query) {
                                  timKiemMonAnTrongNhaHang(query);
                                },
                              ),
                            ),
                            Container(
                              width: 60,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    isContainerVisiable = false;
                                  });
                                },
                                child: const Text(
                                  'Hủy',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: ListView.builder(
                            itemCount: searchResult.length,
                            itemBuilder: ((context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 0.8),
                                )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 250,
                                            child: Text(
                                              '${searchResult[index]['tenMon']}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            NumberFormat('0.000').format(
                                                searchResult[index]['giaTien']),
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 110,
                                      height: 110,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image: AssetImage(
                                              searchResult[index]['hinhAnhMA']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Visibility(
              visible: soLuong != 0,
              maintainSize: false,
              maintainState: true,
              maintainAnimation: true,
              child: Container(
                height: 100,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (phoneNumber.isEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => dangNhapPage(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => gioHangPage(
                                    IDCuaKhachHang: idUser!,
                                    IDCuaNhaHang: widget.IDNhaHang!)),
                          );
                        }
                      },
                      child: Container(
                        height: 65,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('images/hinh_79.png'),
                              height: 35,
                              width: 35,
                              fit: BoxFit.fill,
                              color: Colors.blue,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              soLuongMonAnTrongGioHang.toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (phoneNumber.isEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => dangNhapPage(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => trangThanhToanPage(
                                  IDCuaKhachHang: idUser!,
                                  IDCuaNhaHang: widget.IDNhaHang!),
                            ),
                          );
                          printSL();
                        }
                      },
                      child: Container(
                        height: 65,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: Text(
                          'Trang thanh toán ${NumberFormat("0.000").format(tongTienMonAnTrongGioHang)}đ',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
