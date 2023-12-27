import 'package:baemax/pages/page_DSnhaHangYeuThich.dart';
import 'package:baemax/pages/page_dangNhap.dart';
import 'package:baemax/pages/page_dieuKhoanChinhSach.dart';
import 'package:baemax/pages/page_donHangCuaToi.dart';
import 'package:baemax/pages/page_nhaHangYeuThich.dart';
import 'package:baemax/pages/page_suaDiaChi.dart';
import 'package:baemax/pages/page_thongTinChiTietTaiKhoan.dart';
import 'package:baemax/pages/page_viCoupon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';
import 'page_quanLyThanhToan.dart';
import 'package:baemax/pages/page_soDiaChi.dart';

class thongTinTaiKhoanPage extends StatefulWidget {
  final bool fromLogin;
  thongTinTaiKhoanPage({
    Key? key,
    required this.fromLogin,
  }) : super(key: key);

  @override
  State<thongTinTaiKhoanPage> createState() => _thongTinTaiKhoanPageState();
}

class _thongTinTaiKhoanPageState extends State<thongTinTaiKhoanPage> {
  @override
  void initState() {
    super.initState();
  }

  List<String> nhaHangIds = []; // Khởi tạo danh sách rỗng

  void handleRemove(String idNhaHang) {
    // Xóa nhà hàng có idNhaHang khỏi danh sách nhaHangIds
    nhaHangIds.remove(idNhaHang);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final phoneNumber = user.phoneNumber;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5, // bỏ viền shadow
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
          size: 30,
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
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => thongTinChiTietTaiKhoanPage(
                              keySoDienNguoiDung: user.phoneNumber,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 350,
                              child: Row(
                                children: [
                                  Container(
                                    width: 85,
                                    height: 85,
                                    margin: const EdgeInsets.only(
                                      right: 13,
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
                                                image: AssetImage(
                                                    'images/hinh_34.png'),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  user.phoneNumber.isNotEmpty
                                      ? Text(
                                          user.phoneNumber,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23),
                                        )
                                      : Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      dangNhapPage(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              child: const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Đăng nhập',
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Bao nhiêu món ngon, deals xịn đang chờ bạn kìa!',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color.fromARGB(
                                                          255, 94, 94, 94),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            const Text(
                              '>',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 110,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
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
                                      builder: (context) => donHangCuaToiPage(),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage('images/hinh_23.png'),
                                      fit: BoxFit.cover,
                                      width: 45,
                                      height: 45,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Đơn hàng',
                                      style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection('khachHang')
                                    .where('sdt', isEqualTo: phoneNumber)
                                    .get()
                                    .then((QuerySnapshot snapshot) {
                                  if (snapshot.size > 0) {
                                    String khachHangId = snapshot.docs[0].id;
                                    List<dynamic>? nhaHangIdsData =
                                        (snapshot.docs[0].data() as Map<String,
                                                dynamic>)['nhaHangIds']
                                            as List<dynamic>?;
                                    nhaHangIds = nhaHangIdsData
                                            ?.map((id) => id.toString())
                                            .toList() ??
                                        [];

                                    // Chuyển hướng đến FavoriteRestaurantWidget và truyền danh sách nhaHangIds
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FavoriteRestaurantWidget(
                                          nhaHangIds: nhaHangIds,
                                          IDCuaKhachHang: khachHangId,
                                        ),
                                      ),
                                    );
                                  } else {
                                    print(
                                        'Không tìm thấy tài liệu KhachHang với số điện thoại $phoneNumber');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => dangNhapPage(),
                                      ),
                                    );
                                  }
                                }).catchError((onError) {
                                  print(
                                      'Lỗi khi tìm tài liệu KhachHang: $onError');
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage('images/hinh_24.png'),
                                      fit: BoxFit.cover,
                                      width: 45,
                                      height: 45,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Quán yêu thích',
                                      style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
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
                                      builder: (context) => SoDiaChiPage(),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage('images/hinh_22.png'),
                                      fit: BoxFit.cover,
                                      width: 45,
                                      height: 45,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Sổ địa chỉ',
                                      style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
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
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => viCouponPage(),
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Image(
                              image: AssetImage('images/hinh_25.png'),
                              fit: BoxFit.cover,
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Ví Coupon',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => quanLyThanhToanPage(),
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Image(
                              image: AssetImage('images/hinh_26.png'),
                              fit: BoxFit.cover,
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Quản lý thanh toán',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Xin lỗi bạn nhiều'),
                                content: const Text(
                                  'BaeMax đang phát triển tính năng này. Bạn vui lòng quay lại sau.',
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Row(
                          children: [
                            Image(
                              image: AssetImage('images/hinh_27.png'),
                              fit: BoxFit.cover,
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Chia sẻ thông tin cá nhân',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
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
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Xin lỗi bạn nhiều'),
                                content: const Text(
                                  'BaeMax đang phát triển tính năng này. Bạn vui lòng quay lại sau.',
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Row(
                          children: [
                            Image(
                              image: AssetImage('images/hinh_28.png'),
                              fit: BoxFit.cover,
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Đánh giá BAEMAX',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Xin lỗi bạn nhiều'),
                                content: const Text(
                                  'BaeMax đang phát triển tính năng này. Bạn vui lòng quay lại sau.',
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Row(
                          children: [
                            Image(
                              image: AssetImage('images/hinh_29.png'),
                              fit: BoxFit.cover,
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Thông báo',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Bạn cần hỗ trợ hả'),
                                content: const Text(
                                  'Bạn vui lòng gọi vào 0949162193 hoặc gửi Email đến vuongchihai0711@gmail.com',
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Row(
                          children: [
                            Image(
                              image: AssetImage('images/hinh_30.png'),
                              fit: BoxFit.cover,
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Hỗ trợ',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => dieuKhoanChinhSachPage(),
                          //   ),
                          // );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Thông báo'),
                                content: const Text(
                                  'Bạn đừng quy phạm pháp luật là được. Hãy là 1 công dân tốt',
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Row(
                          children: [
                            Image(
                              image: AssetImage('images/hinh_31.png'),
                              fit: BoxFit.cover,
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Điều khoản và Chính sách',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xffFCF54C),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Thả ga với BAEMAX',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Ẩm thực tuyệt vời, hương vị \nđộc nhất, thỏa mãn mọi khẩu vị.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Image(
                      image: AssetImage('images/hinh_47.png'),
                      width: 100,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Phiên bản hiện tại: V1.0.0',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '>',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'BAEMAX',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff00B2EE),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
