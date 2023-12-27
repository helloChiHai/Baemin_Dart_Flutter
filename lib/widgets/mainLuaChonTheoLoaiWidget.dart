import 'package:flutter/material.dart';

import '../pages/page_danhSachNhaHangDuocApDung.dart';

class main_luaChonTheoLoai_widget extends StatelessWidget {
  const main_luaChonTheoLoai_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_13.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Đãi sinh nhật',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_21.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'KM Đa tầng',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_14.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Flash deals',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_39.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Khao tới 44k',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_7.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Cơm',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_10.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Bún/Phở',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_12.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Cafe/Nước ép',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_8.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Đồ ăn nhanh',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_38.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Ăn vặt',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_11.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Trà sửa',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_16.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Đặc sản',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_9.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Healthy',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_17.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Món Quốc Tế',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_41.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Quán mới',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_12.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Coca 1Đ',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                    ),
                  );
                },
                child: Container(
                  width: 88,
                  height: 85,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/hinh_37.png'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Pepsi 1Đ',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
