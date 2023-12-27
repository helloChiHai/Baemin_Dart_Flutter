import 'package:baemax/pages/page_chiTietPhieuKM.dart';
import 'package:baemax/pages/page_danhSachNhaHangDuocApDung.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ItemPhieuKMViCoupon extends StatefulWidget {
  ItemPhieuKMViCoupon({
    Key? key,
    required this.item,
  }) : super(key: key);

  var item;

  @override
  State<ItemPhieuKMViCoupon> createState() => _ItemPhieuKMViCouponState();
}

class _ItemPhieuKMViCouponState extends State<ItemPhieuKMViCoupon> {
  String maText = 'Zalo';
  late String maSearchText;

  @override
  void initState() {
    super.initState();
    maSearchText = widget.item.id_phieuKM;
  }

  String getPathImage() {
    if (maSearchText.toLowerCase().contains(maText.toLowerCase())) {
      return 'images/hinh_74.png';
    } else {
      return 'images/hinh_18.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      thongTinChiTietPhieuKMPage(item: widget.item),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.white,
              ),
              height: 100,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 5,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(13),
                          bottomLeft: Radius.circular(13)),
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 2.5,
                            vertical: 2.5,
                          ),
                          decoration: BoxDecoration(
                            // color: const Color.fromARGB(255, 177, 215, 246),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white, // Màu trắng ở trên
                                Colors
                                    .lightBlueAccent, // Màu xanh nước biển nhạt ở dưới
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image(
                            image: AssetImage(getPathImage()),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 230,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.item.ten_phieuKM,
                                style: const TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(widget.item.HSD_phieuKM),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Fluttertoast.showToast(
                msg: 'Mã giảm giá đã được sao chép',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Color.fromARGB(255, 97, 97, 97),
                textColor: Colors.white,
                fontSize: 20,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => nhaHangDuocApDungGiamGiaPage(),
                ),
              );
            },
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.white,
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Chọn',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
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
