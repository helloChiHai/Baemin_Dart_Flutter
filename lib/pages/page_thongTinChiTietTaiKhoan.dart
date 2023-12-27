import 'package:baemax/pages/page_chonGioiTinh.dart';
import 'package:baemax/pages/page_chonNgaySinh.dart';
import 'package:baemax/pages/page_chonNgheNghiep.dart';
import 'package:baemax/pages/page_suaThongTin_SDT.dart';
import 'package:baemax/pages/page_suaThongTin_SDT_2.dart';
import 'package:baemax/pages/page_suaThongTin_Ten.dart';
import 'package:baemax/pages/page_thayDoiMatKhau.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';
import 'page_thayDoiEmail.dart';
import 'page_xoaTaiKhoan.dart';

class thongTinChiTietTaiKhoanPage extends StatefulWidget {
  final String keySoDienNguoiDung;
  thongTinChiTietTaiKhoanPage({Key? key, required this.keySoDienNguoiDung})
      : super(key: key);

  @override
  State<thongTinChiTietTaiKhoanPage> createState() =>
      _thongTinChiTietTaiKhoanPageState();
}

class _thongTinChiTietTaiKhoanPageState
    extends State<thongTinChiTietTaiKhoanPage> {
  late String nhanKeySoDienThoaiNguoiDung;

  String idNguoiDung = '';
  String ten = '';
  String sdt = '';
  String email = '';
  int gioiTinh = 1;
  String ngaySinh = '';
  String ngheNhiep = '';

  @override
  void initState() {
    super.initState();
    nhanKeySoDienThoaiNguoiDung = widget.keySoDienNguoiDung;

    fetchDataFromFirebase();
  }

  Future<void> fetchDataFromFirebase() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('khachHang')
          .where('sdt', isEqualTo: nhanKeySoDienThoaiNguoiDung)
          .limit(1)
          .get();

      if (snapshot.size > 0) {
        final nguoiDungData = snapshot.docs[0].data();
        setState(() {
          idNguoiDung = nguoiDungData['idKH'];
          ten = nguoiDungData['hoTen'];
          sdt = nguoiDungData['sdt'];
          email = nguoiDungData['email'];
          gioiTinh = nguoiDungData['gioiTinh'];
          ngaySinh = nguoiDungData['ngaySinh'];
          ngheNhiep = nguoiDungData['ngheNghiep'];
        });
        print('tim thay khach hang');
      }
    } catch (e) {
      print('Error fetching data from Firebase: $e');
    }
  }

  String kiemTraGioiTinh(int gt) {
    if (gt == 0) {
      return 'Nữ';
    } else if (gt == 1) {
      return 'Nam';
    } else if (gt == 2) {
      return 'Khác';
    }
    return '-Chọn-';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Thông tin tài khoản',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xffF8F8FF),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          margin: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: constraints.maxWidth,
                                    height: constraints.maxHeight,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  //AspectRatio: điều chỉnh tỷ lệ khung hình
                                  const AspectRatio(
                                    // aspectRatio: 1.0,
                                    // -> thuộc tính aspectRation: 1.0
                                    // thiết lập tỷ lệ giữa chiều rộng và chiều cao của widget con(tính bằng cách chia chiều rộng cho chiều cao)
                                    aspectRatio: 1.0,
                                    child: Image(
                                      image: AssetImage('images/hinh_34.png'),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tên',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              ten.isEmpty ? '' : ten,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => suaThongTin_Ten_Page(
                                  idCuaNguoiDung: idNguoiDung,
                                  tenCuaNguoiDung: ten,
                                ),
                              ),
                            );
                            print('${idNguoiDung}');
                          },
                          child: const Image(
                            image: AssetImage('images/hinh_32.png'),
                            fit: BoxFit.cover,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: double.infinity, // Độ dài đường thẳng
                      child: const Divider(
                        color: Colors.black, // Màu sắc của đường thẳng
                        thickness: 1.0, // Độ dày của đường thẳng
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Số điện thoại',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              sdt,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => suaTT_SDT_Page_2(
                                  idCuaNguoiDung: idNguoiDung,
                                  sdtCuaNguoiDung: sdt,
                                ),
                              ),
                            );
                          },
                          child: const Image(
                            image: AssetImage('images/hinh_32.png'),
                            fit: BoxFit.cover,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: double.infinity, // Độ dài đường thẳng
                      child: const Divider(
                        color: Colors.black, // Màu sắc của đường thẳng
                        thickness: 1.0, // Độ dày của đường thẳng
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Địa chỉ Email',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              email.isEmpty
                                  ? 'ví dụ: baemax0711@gmail.com'
                                  : email,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => thayDoiEmailPage(
                                  idCuaNguoiDung: idNguoiDung,
                                  emailCuaNguoiDung: email,
                                ),
                              ),
                            );
                          },
                          child: const Image(
                            image: AssetImage('images/hinh_32.png'),
                            fit: BoxFit.cover,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: double.infinity, // Độ dài đường thẳng
                      child: const Divider(
                        color: Colors.black, // Màu sắc của đường thẳng
                        thickness: 1.0, // Độ dày của đường thẳng
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Giới tính',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              gioiTinh.toString().isNotEmpty
                                  ? kiemTraGioiTinh(gioiTinh)
                                  : '-Chọn-',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => chonGioiTinhPage(
                                  idCuaNguoiDung: idNguoiDung,
                                ),
                              ),
                            );
                          },
                          child: const Image(
                            image: AssetImage('images/hinh_32.png'),
                            fit: BoxFit.cover,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ngày sinh',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              ngaySinh.isEmpty ? 'DD/MM/YYYY' : ngaySinh,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => chonNgaySinhPage(
                                  idCuaNguoiDung: idNguoiDung,
                                ),
                              ),
                            );
                          },
                          child: const Image(
                            image: AssetImage('images/hinh_32.png'),
                            fit: BoxFit.cover,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: double.infinity, // Độ dài đường thẳng
                      child: const Divider(
                        color: Colors.black, // Màu sắc của đường thẳng
                        thickness: 1.0, // Độ dày của đường thẳng
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nghề nghiệp',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              ngheNhiep.isEmpty ? '-Chọn-' : ngheNhiep,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => chonNgheNghiepPage(
                                  idCuaNguoiDung: idNguoiDung,
                                ),
                              ),
                            );
                          },
                          child: const Image(
                            image: AssetImage('images/hinh_32.png'),
                            fit: BoxFit.cover,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                child: const Text(
                  '* Các thông tin này sẽ không được hiển thị hoặc chia sẻ cho bất kì ai khác ngoài bạn cả.',
                  style: TextStyle(
                    fontSize: 17.5,
                    color: Color.fromARGB(255, 96, 92, 92),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Đổi mật khẩu',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => doiMatKhauPage(
                              idCuaNguoiDung: idNguoiDung,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        '>',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Xóa Tài Khoản',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => xoaTaiKhoanPage(
                              idCuaNguoiDung: idNguoiDung,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        '>',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Thoát ra hả'),
                              content: const  Text(
                                  'Bạn có chắc chắn muốn thoát ra thiệt hong? (hichic)'),
                              actions: [
                                TextButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    final user = Provider.of<User>(context,
                                        listen: false);
                                    user.clearInfo();
                                    Navigator.popUntil(context,
                                        (route) => route.settings.name == '/');
                                  },
                                ),
                                TextButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    // Xử lý khi nhấn No
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Thoát ra',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
