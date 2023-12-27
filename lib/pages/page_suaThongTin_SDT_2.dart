import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class suaTT_SDT_Page_2 extends StatefulWidget {
  final String idCuaNguoiDung;
  final String sdtCuaNguoiDung;
  suaTT_SDT_Page_2({
    Key? key,
    required this.idCuaNguoiDung,
    required this.sdtCuaNguoiDung,
  }) : super(key: key);

  @override
  State<suaTT_SDT_Page_2> createState() => _suaTT_SDT_Page_2State();
}

class _suaTT_SDT_Page_2State extends State<suaTT_SDT_Page_2> {
  String SDTHienTai = '';
  String SDTMoi = '';
  String IDnguoiDung = '';

  bool kiemTraSDTTrungNhau(String sdtHienTai, String sdtMoi) {
    return sdtHienTai == sdtMoi;
  }

  @override
  void initState() {
    super.initState();
    SDTHienTai = widget.sdtCuaNguoiDung;
    IDnguoiDung = widget.idCuaNguoiDung;
  }

  Future<void> capNhatSDTNguoiDungTheoID(String newUserNumberPhone) async {
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
            .update({'sdt': newUserNumberPhone});

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Số điện thoại đã được cập nhật thành công.'),
        ));
      }
    } catch (e) {
      print('Loi cap nhat ten: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Đã xảy ra lỗi khi cập nhật Số điện thoại.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nhập số điện thoại của bạn để tiếp túc nhé',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Mã xác nhận sẽ được gởi qua số điện thoại này',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 96, 92, 92),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: kiemTraSDTTrungNhau(SDTHienTai, SDTMoi)
                      ? Colors.red
                      : Colors.blue,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: Row(
                children: [
                  const Image(
                    image: AssetImage('images/hinh_57.png'),
                    width: 40,
                    height: 40,
                  ),
                  const Text(
                    '+84 ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    '|',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Số điện thoại',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      onChanged: (value) {
                        setState(() {
                          SDTMoi = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            kiemTraSDTTrungNhau(SDTHienTai, SDTMoi)
                ? const Text(
                    'Số điện thoại đã được sử dụng',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
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
                    onPressed: SDTMoi.isEmpty
                        ? null
                        : () async {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => nhapMatKhauPage(
                            //       sdtVuaNhap: SDTMoi,
                            //     ),
                            //   ),
                            // );
                            capNhatSDTNguoiDungTheoID(SDTMoi);
                          },
                    child: const Text(
                      'Tiếp theo',
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
