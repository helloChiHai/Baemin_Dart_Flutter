import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class chonGioiTinhPage extends StatefulWidget {
  final String idCuaNguoiDung;
  chonGioiTinhPage({
    Key? key,
    required this.idCuaNguoiDung,
  }) : super(key: key);

  @override
  State<chonGioiTinhPage> createState() => _chonGioiTinhPageState();
}

class _chonGioiTinhPageState extends State<chonGioiTinhPage> {
  int gioiTinhDuocChon = -1;
  String IDnguoiDung = '';

  @override
  void initState() {
    super.initState();
    IDnguoiDung = widget.idCuaNguoiDung;
  }

  Future<void> capNhatGioiTinhNguoiDungTheoID(int newUserGioiTinh) async {
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
            .update({'gioiTinh': newUserGioiTinh});

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Giới tính đã được cập nhật thành công.'),
        ));
      }
    } catch (e) {
      print('Loi cap nhat ten: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Đã xảy ra lỗi khi cập nhật Giới tính.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Giới tính',
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
          icon: const Icon(Icons.close),
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
              'Giúp BAEMAX xưng hô với bạn dễ hơn nha',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  gioiTinhDuocChon = 1;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nam',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: gioiTinhDuocChon == 1
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: 286,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: gioiTinhDuocChon == 1
                        ? Colors.blue
                        : Colors.transparent,
                    size: 35,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  gioiTinhDuocChon = 0;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nữ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: gioiTinhDuocChon == 0
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: gioiTinhDuocChon == 0
                        ? Colors.blue
                        : Colors.transparent,
                    size: 35,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  gioiTinhDuocChon = 2;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Khác',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: gioiTinhDuocChon == 2
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: 285,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: gioiTinhDuocChon == 2
                        ? Colors.blue
                        : Colors.transparent,
                    size: 35,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: gioiTinhDuocChon == -1
                        ? null
                        : () async {
                            capNhatGioiTinhNguoiDungTheoID(gioiTinhDuocChon);
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
