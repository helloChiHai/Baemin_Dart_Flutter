import 'dart:math';

import 'package:baemax/models/MonAn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../pages/page_hopThu.dart';
import '../pages/page_thongTinTaiKhoan.dart';

class main_header_widget extends StatelessWidget {
  const main_header_widget({
    super.key,
  });

    String RandomIDMonAn() {
    // Tạo danh sách các ký tự từ A đến Z
    List<String> letters = List.generate(
        26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));

    // Tạo danh sách các số từ 0 đến 9
    List<String> numbers = List.generate(10, (index) => index.toString());

    // Sử dụng hàm random trong thư viện dart:math
    Random random = Random();

    // Lấy ngẫu nhiên 3 chữ cái từ danh sách letters
    List<String> randomLetters =
        List.generate(10, (index) => letters[random.nextInt(letters.length)]);

    // Lấy ngẫu nhiên 3 số từ danh sách numbers
    List<String> randomNumbers =
        List.generate(10, (index) => numbers[random.nextInt(numbers.length)]);

    // Kết hợp chữ cái và số ngẫu nhiên thành một chuỗi
    String randomString = randomLetters.join('') + randomNumbers.join('');

    return randomString;
  }

  void themMonAnVaoNhaHang(MonAn monAn, String idNhaHang) {
    FirebaseFirestore.instance
        .collection('nhaHang')
        .doc(idNhaHang)
        .collection('monAn')
        .add({
      'IDMonAn': monAn.IDMonAn,
      'tenMon': monAn.tenMon,
      'hinhAnhMA': monAn.hinhAnhMA,
      'giaTien': monAn.giaTien,
    }).then((value) {
      print('thêm món ăn thành công vào nhà hàng $idNhaHang');
    }).catchError((onError) {
      print('thêm món ăn không thành công vào nhà hàng $onError');
    });
  }

  void themDuLieuDenFiestore() {
    MonAn monAn = MonAn(
      IDMonAn: RandomIDMonAn(),
      tenMon: 'Bia Pilsner Urquell',
      hinhAnhMA: 'images/hinh_149.jpg',
      giaTien: 60.000,
    );
    String idNhaHang = 'aaLBkCzoHUc6F2HLWomE';
    themMonAnVaoNhaHang(monAn, idNhaHang);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            child: const Row(
              children: [
                Image(
                  image: AssetImage('images/hinh_20.png'),
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'ktx >',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                // GestureDetector(
                //   onTap: () {
                //     themDuLieuDenFiestore();
                //   },
                //   child: Container(
                //     child: Text('data'),
                //   ),
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => hopThuPage(),
                      ),
                    );
                  },
                  child: const Image(
                    image: AssetImage('images/hinh_19.png'),
                    width: 20,
                    height: 20,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => thongTinTaiKhoanPage(fromLogin: false),
                      ),
                    );
                  },
                  child: const Image(
                    image: AssetImage('images/hinh_35.png'),
                    width: 20,
                    height: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
