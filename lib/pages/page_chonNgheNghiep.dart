import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class chonNgheNghiepPage extends StatefulWidget {
  final String idCuaNguoiDung;

  chonNgheNghiepPage({
    Key? key,
    required this.idCuaNguoiDung,
  }) : super(key: key);

  @override
  State<chonNgheNghiepPage> createState() => _chonNgheNghiepPageState();
}

class _chonNgheNghiepPageState extends State<chonNgheNghiepPage> {
  int ngheNghiepDuocChon = -1;
  String chonNgheNghiep = '';

  String IDnguoiDung = '';

  @override
  void initState() {
    super.initState();
    IDnguoiDung = widget.idCuaNguoiDung;
  }

    Future<void> capNhatNgheNghiepNguoiDungTheoID(String newUserNgheNghiep) async {
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
            .update({'ngheNghiep': newUserNgheNghiep});

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Nghề nghiệp đã được cập nhật thành công.'),
        ));
      }
    } catch (e) {
      print('Loi cap nhat ten: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Đã xảy ra lỗi khi cập nhật nghề nghiệp.'),
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
          'Nghề nghiệp',
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
          children: [
            const Text(
              'Giúp BAEMAX có thể gợi ý các món ăn phù hợp cho bạn',
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
                  ngheNghiepDuocChon = 0;
                  chonNgheNghiep = 'Nhân viên văn phòng';
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(
                    image: AssetImage(
                      'images/hinh_58.png',
                    ),
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  const Text(
                    'Nhân viên văn phòng',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: ngheNghiepDuocChon == 0
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
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  ngheNghiepDuocChon = 1;
                  chonNgheNghiep = 'Nội trợ';
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(
                    image: AssetImage(
                      'images/hinh_59.png',
                    ),
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  const Text(
                    'Nội trợ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 210,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: ngheNghiepDuocChon == 1
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
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  ngheNghiepDuocChon = 2;
                  chonNgheNghiep = 'Học sinh, sinh viên';
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(
                    image: AssetImage(
                      'images/hinh_60.png',
                    ),
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  const Text(
                    'Học sinh, sinh viên',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: ngheNghiepDuocChon == 2
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
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  ngheNghiepDuocChon = 3;
                  chonNgheNghiep = 'Làm tự do';
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(
                    image: AssetImage(
                      'images/hinh_61.png',
                    ),
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  const Text(
                    'Làm tự do',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 190,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: ngheNghiepDuocChon == 3
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
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  ngheNghiepDuocChon = 4;
                  chonNgheNghiep = 'Công nhân';
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(
                    image: AssetImage(
                      'images/hinh_62.png',
                    ),
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  const Text(
                    'Công nhân',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: ngheNghiepDuocChon == 4
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
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  ngheNghiepDuocChon = 5;
                  chonNgheNghiep = 'Khác';
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(
                    image: AssetImage(
                      'images/hinh_63.png',
                    ),
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  const Text(
                    'Khác',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 230,
                    height: 25,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: ngheNghiepDuocChon == 5
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
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: ngheNghiepDuocChon == -1
                        ? null
                        : () {
                            print('$chonNgheNghiep');
                            capNhatNgheNghiepNguoiDungTheoID(chonNgheNghiep);
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
