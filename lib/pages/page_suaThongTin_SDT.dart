import 'package:baemax/pages/page_nhapMatKhau.dart';
import 'package:flutter/material.dart';

class suaThongTin_SDT_Page extends StatefulWidget {
  const suaThongTin_SDT_Page({super.key});

  @override
  State<suaThongTin_SDT_Page> createState() => _suaThongTin_SDT_PageState();
}

class _suaThongTin_SDT_PageState extends State<suaThongTin_SDT_Page> {
  String SDTMoi = '';

  bool kiemTraSDTTrungNhau(String sdtHienTai, String sdtMoi) {
    return sdtHienTai == sdtMoi;
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
                  color: Colors.blue,
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
            // const Text(
            //   'Số điện thoại đã được sử dụng',
            //   style: TextStyle(
            //     color: Colors.red,
            //     fontSize: 15,
            //   ),
            // ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: SDTMoi.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => nhapMatKhauPage(
                                  sdtVuaNhap: SDTMoi,
                                ),
                              ),
                            );
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
