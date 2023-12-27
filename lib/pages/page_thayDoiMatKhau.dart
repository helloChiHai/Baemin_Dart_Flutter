import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class doiMatKhauPage extends StatefulWidget {
  final String idCuaNguoiDung;

  doiMatKhauPage({
    Key? key,
    required this.idCuaNguoiDung,
  }) : super(key: key);

  @override
  State<doiMatKhauPage> createState() => _doiMatKhauPageState();
}

class _doiMatKhauPageState extends State<doiMatKhauPage> {
  String matKhauMoi = '';
  String xacNhanMatKhauMoi = '';
  bool hienThiThongBaoLoi_doDai = false;
  bool hienThiThongBaoLoi_trungKhopMatKhau = false;

  String IDnguoiDung = '';

  @override
  void initState() {
    super.initState();
    IDnguoiDung = widget.idCuaNguoiDung;
  }

  Future<void> capNhatMatKhauNguoiDungTheoID(String newUserMatKhau) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('khachHang')
          .where('idKH', isEqualTo: IDnguoiDung)
          .limit(1)
          .get();

      if (snapshot.size > 0) {
        final khachHangID = snapshot.docs[0].id;
        await FirebaseFirestore.instance
            .collection('khachHang')
            .doc(khachHangID)
            .update({'matKhau': newUserMatKhau});

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Mật khẩu đã được cập nhật thành công.'),
        ));
      }
    } catch (e) {
      print('Loi cap nhat ten: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Đã xảy ra lỗi khi cập nhật mật khẩu.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Thay đổi mật khẩu',
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mật khẩu mới',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Nhập mật khẩu mới',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              onChanged: (value) {
                setState(
                  () {
                    matKhauMoi = value.isEmpty ? '' : value;
                    hienThiThongBaoLoi_doDai = matKhauMoi.length < 6;
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            hienThiThongBaoLoi_doDai
                ? const Text(
                    'Độ dài tối thiểu là 6 ký tự',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Xác nhận khẩu mới',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Xác nhận mật khẩu',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              onChanged: (value) {
                setState(
                  () {
                    xacNhanMatKhauMoi = value.isEmpty ? '' : value;
                    hienThiThongBaoLoi_trungKhopMatKhau =
                        (xacNhanMatKhauMoi != matKhauMoi);
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            hienThiThongBaoLoi_trungKhopMatKhau
                ? const Text(
                    'Mật khẩu không trùng khớp',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                    ),
                  )
                : const SizedBox(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        matKhauMoi != xacNhanMatKhauMoi || matKhauMoi.isEmpty
                            ? null
                            : () async {
                                capNhatMatKhauNguoiDungTheoID(matKhauMoi);
                              },
                    child: const Text(
                      'Lưu',
                      style: TextStyle(
                        fontSize: 20,
                      ),
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
