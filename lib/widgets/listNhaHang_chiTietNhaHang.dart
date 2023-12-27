import 'package:baemax/widgets/chiTietIemNhaHangDuocApDung.dart';
import 'package:flutter/material.dart';

class dsNhaHang extends StatelessWidget {
  dsNhaHang({
    Key? key,
    required this.item,
  }) : super(key: key);

  var item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => itemChiTietNhaHangDuocApDung(item: item),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 125,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage('images/hinh_73.jpg'),
                      fit: BoxFit.cover,
                      width: 100,
                      height: 105,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'PROMO',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 220,
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('images/hinh_78.png'),
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Container(
                            width: 250,
                            child: Text(
                              item.tenNH,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 220,
                    child: Text(
                      item.monAn,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      softWrap: true,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 220,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 27,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${item.danhGia} ',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              const TextSpan(
                                text: ' (999+)',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '· ${item.khoangCach} km',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 72, 72, 72),
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
    );
  }
}
