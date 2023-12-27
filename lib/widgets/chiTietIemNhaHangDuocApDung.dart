import 'package:baemax/pages/page_chiTietMonAn.dart';
import 'package:baemax/pages/page_gioHang.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class itemChiTietNhaHangDuocApDung extends StatefulWidget {
  itemChiTietNhaHangDuocApDung({
    Key? key,
    required this.item,
  }) : super(key: key);

  final dynamic item;

  @override
  State<itemChiTietNhaHangDuocApDung> createState() =>
      _itemChiTietNhaHangDuocApDungState();
}

class _itemChiTietNhaHangDuocApDungState
    extends State<itemChiTietNhaHangDuocApDung> {
  late ScrollController scrollController;
  late bool showAppBar;
  bool showAppBarDanhMucLoaiMonAn = false;
  late Color iconColor;
  double khoangCachTruocKhiAnAppBarDM = 25;
  bool isContainerVisiable = false;
  late bool checkedHeart;
  int soLuong = 0;
  double soTien = 0;

  void hienThiContainerTimKiem() {
    setState(() {
      isContainerVisiable = true;
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    showAppBar = true;
    iconColor = Colors.white;
    checkedHeart = false;

    scrollController.addListener(() {
      if (scrollController.offset > 0 &&
          scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        setState(() {
          showAppBar = false;
          iconColor = Colors.black;
        });
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          showAppBar = true;
          iconColor = Colors.white;
        });
      }
      if (scrollController.offset > khoangCachTruocKhiAnAppBarDM &&
          !scrollController.position.outOfRange) {
        setState(() {
          showAppBarDanhMucLoaiMonAn = true;
        });
      } else {
        setState(() {
          showAppBarDanhMucLoaiMonAn = false;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: Color.fromARGB(255, 225, 225, 225),
                  child: Column(
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 300,
                                    child: const Image(
                                      image: AssetImage('images/hinh_73.jpg'),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 230,
                              left: 10.0,
                              right: 10.0,
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xffDDDDDD),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 15,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 3,
                                        vertical: 3,
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'images/hinh_78.png'),
                                            width: 27,
                                            height: 27,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'ĐỐI TÁC CỦA BEAMAX',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      widget.item.tenNH,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${widget.item.khoangCach}km',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 280,
                                          child: Text(
                                            widget.item.diaChiNH,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 110, 109, 109),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage('images/hinh_19.png'),
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Giao bởi tài xế',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  'Thay đổi',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage('images/hinh_28.png'),
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '4.7',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '(999+)',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage('images/hinh_28.png'),
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '999+ đã bán',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  'Xem đánh giá',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Nhất định phải thử',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image(
                                  image: AssetImage('images/hinh_19.png'),
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 180,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image:
                                              AssetImage('images/hinh_73.jpg'),
                                          fit: BoxFit.cover,
                                          width: 180,
                                          height: 150,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 180,
                                        child: Text(
                                          'Bột chiên 1 trứng',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 180,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image:
                                              AssetImage('images/hinh_73.jpg'),
                                          fit: BoxFit.cover,
                                          width: 180,
                                          height: 150,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 180,
                                        child: Text(
                                          'Bột chiên 1 trứng',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Thập cẩm/ Mixed',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image(
                                  image: AssetImage('images/hinh_19.png'),
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => chiTietMonAnPage(),
                                  ),
                                ).then((value) {
                                  if (value != null &&
                                      value is List<dynamic> &&
                                      value.length == 2) {
                                    setState(() {
                                      soLuong = value[0];
                                      soTien = value[1];
                                    });
                                    print('sl: $soLuong - TONG: $soTien');
                                  }
                                });
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 130,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Bột khoai môn 3 trứng',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                            softWrap: true,
                                          ),
                                          Text(
                                            '45.000 đ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image: AssetImage('images/hinh_73.jpg'),
                                        fit: BoxFit.cover,
                                        width: 150,
                                        height: 150,
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
                                    builder: (context) => chiTietMonAnPage(),
                                  ),
                                );
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 130,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Bột khoai môn 3 trứng',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                            softWrap: true,
                                          ),
                                          Text(
                                            '45.000 đ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image: AssetImage('images/hinh_73.jpg'),
                                        fit: BoxFit.cover,
                                        width: 150,
                                        height: 150,
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
                                    builder: (context) => chiTietMonAnPage(),
                                  ),
                                );
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 130,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Bột khoai môn 3 trứng',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                            softWrap: true,
                                          ),
                                          Text(
                                            '45.000 đ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image: AssetImage('images/hinh_73.jpg'),
                                        fit: BoxFit.cover,
                                        width: 150,
                                        height: 150,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 135,
            child: Column(
              children: [
                //appabr + icon
                Container(
                  height: 80,
                  color: !showAppBarDanhMucLoaiMonAn
                      ? Colors.transparent
                      : Colors.white,
                  padding: const EdgeInsets.only(
                    top: 20,
                    right: 10,
                    left: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape
                                .circle, // Đặt hình dạng thành hình tròn
                            color: !showAppBarDanhMucLoaiMonAn
                                ? Color.fromARGB(255, 101, 101, 101)
                                : Colors.transparent,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: !showAppBarDanhMucLoaiMonAn
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      !showAppBarDanhMucLoaiMonAn
                          ? AnimatedOpacity(
                              opacity: 1,
                              duration: const Duration(milliseconds: 400),
                              child: Container(
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print('đã nhấn tìm kiếm');
                                        hienThiContainerTimKiem();
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Đặt hình dạng thành hình tròn
                                          color: Color.fromARGB(
                                              255, 101, 101, 101),
                                        ),
                                        child: Icon(
                                          Icons.search,
                                          color: iconColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('đã nhấn tym');
                                        setState(() {
                                          checkedHeart = !checkedHeart;
                                        });
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Đặt hình dạng thành hình tròn
                                          color: Color.fromARGB(
                                              255, 101, 101, 101),
                                        ),
                                        child: Icon(
                                          checkedHeart
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: checkedHeart
                                              ? Colors.red
                                              : iconColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('đã nhấn share');
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Đặt hình dạng thành hình tròn
                                          color: Color.fromARGB(
                                              255, 101, 101, 101),
                                        ),
                                        child: Icon(
                                          Icons.share,
                                          color: iconColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : AnimatedOpacity(
                              opacity: 1,
                              duration: const Duration(milliseconds: 400),
                              child: Container(
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print('đã nhấn tìm kiếm');
                                        hienThiContainerTimKiem();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 245, 235, 235),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.search,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 238,
                                              child: Text(
                                                '${widget.item.tenNH} - ${widget.item.diaChiNH}',
                                                // '${widget.item.tenNH}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('đã nhấn tym');
                                        setState(() {
                                          checkedHeart = !checkedHeart;
                                        });
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Đặt hình dạng thành hình tròn
                                          color: Colors.transparent,
                                        ),
                                        child: Icon(
                                          checkedHeart
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: checkedHeart
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                // appbar + search
                Expanded(
                  child: AnimatedOpacity(
                    opacity: showAppBarDanhMucLoaiMonAn ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5, // làm mềm
                            spreadRadius: 0, // mở rộng
                            offset: const Offset(
                              0, // di chuyển sang phải theo chiều ngang
                              5.0, // dieu chuyển xuống dưới theo chiều dọc
                            ),
                          ),
                        ],
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          GestureDetector(
                            child: Container(
                              height: 55,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 163, 240, 225),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Món hot',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 1, 106, 78),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            child: Container(
                              height: 55,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Milk tea',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            child: Container(
                              height: 55,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Milk',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            child: Container(
                              height: 55,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Tea',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            child: Container(
                              height: 55,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Special drinks',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            child: Container(
                              height: 55,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Soda',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // search
          isContainerVisiable
              ? Container(
                  height: double.infinity,
                  color: Colors.grey.withOpacity(0.3),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              child: const Icon(
                                Icons.search,
                              ),
                            ),
                            Container(
                              width: 300,
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: 'Tìm trong thực đơn',
                                  hintStyle: TextStyle(
                                    fontSize: 19,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    isContainerVisiable = false;
                                  });
                                },
                                child: const Text(
                                  'Hủy',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Visibility(
              visible: soTien != 0,
              maintainSize: false,
              maintainState: true,
              maintainAnimation: true,
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => gioHangPage(),
                  //   ),
                  // );
                },
                child: Container(
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 65,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('images/hinh_79.png'),
                              height: 35,
                              width: 35,
                              fit: BoxFit.fill,
                              color: Colors.blue,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${soLuong}',
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 65,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: Text(
                          'Trang thanh toán ${NumberFormat("0.000").format(soTien)}đ',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
