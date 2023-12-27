import 'package:baemax/modal/phieuKM.dart';
import 'package:baemax/widgets/viCoupon_ItemphieuKM.dart';
import 'package:flutter/material.dart';

class SubScreen_2 extends StatefulWidget {
  const SubScreen_2({super.key});

  @override
  State<SubScreen_2> createState() => _SubScreen_2State();
}

class _SubScreen_2State extends State<SubScreen_2> {
  DateTime dateTiemNow = DateTime.now();

  final List<PhieuKM> itemsPhieuKMs = [
    PhieuKM(
      id_phieuKM: 'KM01',
      ten_phieuKM: 'Rảnh thì cho',
      HSD_phieuKM: DateTime(2023, 06, 30),
      noiDung_phieuKM: [
        'Coupon giảm 15000đ cho đơn từ 30000đ.',
        'Coupon áp dụng cho các nhà hàng có trong chương trình.',
        'Coupon sử dụng được nhiều lần trong ngày.',
        'Chương trình có thể thay đổi nội dung và kết thúc sớm hơn dự kiến theo chính sách công ty.',
        'Để biết thêm chi tiết, vui lòng liên hệ bộ phân Chăm Sóc Khác Hàng qua SĐT: 0949162193 hoặc Email: vuongchihai0711@gmail.com',
      ],
    ),
    PhieuKM(
      id_phieuKM: 'ZALOKHAO',
      ten_phieuKM: 'Rảnh thì cho',
      HSD_phieuKM: DateTime(2023, 06, 30),
      noiDung_phieuKM: [
        'Coupon giảm 15000đ cho đơn từ 30000đ.',
        'Coupon áp dụng cho các nhà hàng có trong chương trình.',
        'Coupon sử dụng được nhiều lần trong ngày.',
        'Chương trình có thể thay đổi nội dung và kết thúc sớm hơn dự kiến theo chính sách công ty.',
        'Để biết thêm chi tiết, vui lòng liên hệ bộ phân Chăm Sóc Khác Hàng qua SĐT: 0949162193 hoặc Email: vuongchihai0711@gmail.com',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        color: const Color.fromARGB(255, 240, 238, 238),
        width: double.infinity,
        height: double.infinity,
        // child: SingleChildScrollView(
        //   child: Column(
        //     children: itemsPhieuKMs
        //         .map((item) => Column(
        //               children: [
        //                 ItemPhieuKMViCoupon(
        //                   item: item,
        //                 ),
        //                 const SizedBox(
        //                   height: 15,
        //                 ),
        //               ],
        //             ))
        //         .toList(),
        //   ),
        // ),
      ),
    );
  }
}
