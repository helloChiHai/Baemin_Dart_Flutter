import 'package:baemax/pages/page_chiTietNhaHang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteRestaurantWidget extends StatefulWidget {
  final List<String> nhaHangIds;
  final String IDCuaKhachHang;

  FavoriteRestaurantWidget(
      {required this.nhaHangIds, required this.IDCuaKhachHang});

  @override
  State<FavoriteRestaurantWidget> createState() =>
      _FavoriteRestaurantWidgetState();
}

class _FavoriteRestaurantWidgetState extends State<FavoriteRestaurantWidget> {
  String idKhachHang = '';

  @override
  void initState() {
    super.initState();
    idKhachHang = widget.IDCuaKhachHang;
  }

  void handleRemove(String idNhaHang) {
    setState(() {
      widget.nhaHangIds.remove(idNhaHang); // Xóa nhà hàng khỏi danh sách
    });

    FirebaseFirestore.instance
        .collection('khachHang')
        .doc(idKhachHang)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        String khachHangId = snapshot.id;

        FirebaseFirestore.instance
            .collection('khachHang')
            .doc(khachHangId)
            .update({'nhaHangIds': widget.nhaHangIds}).then((_) {
          print('Cập nhật danh sách nhà hàng thành công');
        }).catchError((error) {
          print('Lỗi khi cập nhật danh sách nhà hàng: $error');
        });
      } else {
        print('Không tìm thấy tài liệu KhachHang với id $idKhachHang');
      }
    }).catchError((onError) {
      print('Lỗi khi tìm tài liệu KhachHang: $onError');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
          title: const Text(
            'Nhà hàng yêu thích',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: ListView.builder(
          itemCount: widget.nhaHangIds.length,
          itemBuilder: (context, index) {
            String idNhaHang = widget.nhaHangIds[index];

            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('nhaHang')
                  .doc(idNhaHang)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Lỗi: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (!snapshot.hasData) {
                  return Text('Không có dữ liệu');
                }

                // Lấy thông tin nhà hàng từ tài liệu snapshot
                Map<String, dynamic>? nhaHangData =
                    snapshot.data!.data() as Map<String, dynamic>?;

                if (nhaHangData == null) {
                  return Text('Dữ liệu nhà hàng không hợp lệ');
                }

                num slDaBan = nhaHangData['SLDaBan'] ?? 0;
                String hinhAnh = nhaHangData['anhDaiDienNH'] ?? '';
                String diaChi = nhaHangData['diaChiNH'] ?? '';
                num danhGia = nhaHangData['danhGia'] ?? 0;
                num khoangCach = nhaHangData['khoangCach'] ?? 0;
                String tenNhaHang = nhaHangData['tenNH'] ?? '';

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => chiTietNhaHangPage(
                                  IDNhaHang: idNhaHang,
                                  tenNH: tenNhaHang,
                                  anhDaiDienNH: hinhAnh,
                                  diaChiNH: diaChi,
                                  khoangCach: khoangCach,
                                  danhGia: danhGia,
                                  SLDaBan: slDaBan,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromARGB(255, 98, 98, 98),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 110,
                                      height: 110,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image: AssetImage(hinhAnh),
                                          width: 110,
                                          height: 110,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 240,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color:
                                                Color.fromARGB(255, 98, 98, 98),
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tenNhaHang,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                const Image(
                                                  image: AssetImage(
                                                      'images/hinh_72.png'),
                                                  width: 20,
                                                  height: 20,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${danhGia}',
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  '(${slDaBan}+)',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromARGB(
                                                        255, 98, 98, 98),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                Text(
                                                  '${khoangCach}km',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromARGB(
                                                        255, 98, 98, 98),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            handleRemove(idNhaHang);
                                          },
                                          child: const Image(
                                            image: AssetImage(
                                                'images/hinh_71.png'),
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
