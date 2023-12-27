import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class thongTinChiTietPhieuKMPage extends StatefulWidget {
  thongTinChiTietPhieuKMPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final dynamic item;

  @override
  State<thongTinChiTietPhieuKMPage> createState() =>
      _thongTinChiTietPhieuKMPageState();
}

class _thongTinChiTietPhieuKMPageState
    extends State<thongTinChiTietPhieuKMPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Cho phép body hiển thị phía sau AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          size: 30,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          color: const Color.fromARGB(255, 174, 243, 248),
                          width: double.infinity,
                          height: 300,
                          padding: const EdgeInsets.only(
                            top: 90,
                          ),
                          child: const Image(
                            image: AssetImage('images/hinh_53.png'),
                          ),
                        ),
                        Container(
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 250,
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
                            blurRadius: 8,
                            spreadRadius: 2,
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.blue,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 3,
                            ),
                            child: Text(
                              widget.item.id_phieuKM,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            widget.item.ten_phieuKM,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Sử dụng đến: ',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(
                                  text: DateFormat('dd/MM/yyyy')
                                      .format(widget.item.HSD_phieuKM),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 110, 109, 109),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (widget.item.noiDung_phieuKM as List<String>)
                    .map((noiDung) => Column(
                          children: [
                            Text(
                              '*  $noiDung',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
