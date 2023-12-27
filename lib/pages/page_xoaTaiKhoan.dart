import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';

class xoaTaiKhoanPage extends StatefulWidget {
  final String idCuaNguoiDung;
  const xoaTaiKhoanPage({
    Key? key,
    required this.idCuaNguoiDung,
  }) : super(key: key);

  @override
  State<xoaTaiKhoanPage> createState() => _xoaTaiKhoanPageState();
}

class _xoaTaiKhoanPageState extends State<xoaTaiKhoanPage> {
  String IDnguoiDung = '';
  bool _isDisposed = false; // Thêm biến này

  @override
  void initState() {
    super.initState();
    IDnguoiDung = widget.idCuaNguoiDung;
  }

  @override
  void dispose() {
    _isDisposed =
        true; // Đặt biến _isDisposed thành true trong phương thức dispose()
    super.dispose();
  }

  Future<void> xoaNguoiDungTheoID(String idNguoiDung) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('khachHang')
          .where('idKH', isEqualTo: idNguoiDung)
          .limit(1)
          .get();

      if (snapshot.size > 0) {
        final khachHangID = snapshot.docs[0].id;
        await FirebaseFirestore.instance
            .collection('khachHang')
            .doc(khachHangID)
            .delete();

        if (!_isDisposed) {
          // Kiểm tra _isDisposed trước khi thao tác với context
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Người dùng đã được xóa thành công.'),
          ));
        }
      }
    } catch (e) {
      print('Loi cap nhat ten: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Đã xảy ra lỗi khi xóa người dùng.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 221, 217, 217),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180,
              color: Color.fromARGB(255, 221, 217, 217),
              child: const Image(
                image: AssetImage('images/hinh_70.png'),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ủa tính nghỉ chơi BAEMAX thiệt hả?',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Lưu ý: Tài khoản sau khi xóa sẽ không thể phục hồi lại được.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Bạn sẽ mất tất cả thông tin và ưu đãi cá nhân bao gồm ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 98, 98, 98),
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text:
                              'coupon, lợi ích từ BESTBAE, nhà hàng yêu thích, nhận xét, đơn hàng và địa chỉ đã lưu.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sau khi xóa tài khoản, bạn sẽ ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 98, 98, 98),
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text:
                              'không thể dùng lại email và số điện thoại của tài khoản này để tạo tài khoản mới luôn nha bạn yêu.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Bộ phận CSKH của BAEMAX sẽ không thể hỗ trợ bạn phục hồi tài khoản.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Thôi không xóa nữa',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        xoaNguoiDungTheoID(IDnguoiDung);
                        final user = Provider.of<User>(context, listen: false);
                        user.clearInfo();
                        Navigator.popUntil(
                            context, (route) => route.settings.name == '/');
                      },
                      child: const Text(
                        'Xóa tài khoản này',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
