import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class thayDoiEmailPage extends StatefulWidget {
    final String idCuaNguoiDung;
  final String emailCuaNguoiDung;
  const thayDoiEmailPage({Key? key,
    required this.idCuaNguoiDung,
    required this.emailCuaNguoiDung,
  }) : super(key: key);

  @override
  State<thayDoiEmailPage> createState() => _thayDoiEmailPageState();
}

class _thayDoiEmailPageState extends State<thayDoiEmailPage> {
  String emailHienTai = '';
  String thongBaoLoi = '';
    String IDnguoiDung = '';

    
  @override
  void initState() {
    super.initState();
    emailHienTai = widget.emailCuaNguoiDung;
    IDnguoiDung = widget.idCuaNguoiDung;
  }

    Future<void> capNhatEmailNguoiDungTheoID(String newUserEmail) async {
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
            .update({'email': newUserEmail});

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Email đã được cập nhật thành công.'),
        ));
      }
    } catch (e) {
      print('Loi cap nhat ten: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Đã xảy ra lỗi khi cập nhật Email.'),
      ));
    }
  }

  bool validateEmail(String input) {
    String emailPattern =
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$'; // Biểu thức chính quy kiểm tra địa chỉ email
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Thay đổi email',
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
          icon: const Icon(Icons.close), // Thay đổi icon thành 'x'
          onPressed: () {
            Navigator.pop(context);
          },
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
              'Một email xác nhận sẽ được gửi đến bạn.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Địa chỉ Email',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: emailHienTai,
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              onChanged: (value) {
                setState(() {
                  emailHienTai = value;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            emailHienTai.isEmpty
                ? const Text(
                    'Vui lòng nhập email.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  )
                : thongBaoLoi.isNotEmpty
                    ? Text(
                        thongBaoLoi,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      )
                    : SizedBox(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: emailHienTai.isEmpty
                        ? null
                        : () {
                            setState(() {
                              if (emailHienTai.isEmpty) {
                                thongBaoLoi = 'Vui lòng nhập email.';
                              } else if (!validateEmail(emailHienTai)) {
                                thongBaoLoi = 'Không phải email, Vui lòng nhập lại.';
                              } else {
                                thongBaoLoi = '';
                                // xu ly luu email
                                capNhatEmailNguoiDungTheoID(emailHienTai);
                              }
                            });
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
