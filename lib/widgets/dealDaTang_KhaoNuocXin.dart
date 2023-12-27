import 'package:baemax/models/NhaHang.dart';
import 'package:baemax/pages/page_chiTietNhaHang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baemax/pages/page_chiTietDeal.dart';
import 'package:flutter/material.dart';

class khaoNuocXin_DealDaTang extends StatefulWidget {
  const khaoNuocXin_DealDaTang({super.key});

  @override
  State<khaoNuocXin_DealDaTang> createState() => _khaoNuocXin_DealDaTangState();
}

class _khaoNuocXin_DealDaTangState extends State<khaoNuocXin_DealDaTang> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => chiTietDealPage(),
                ),
              );
            },
            child: Container(
              child: Row(
                children: [
                  Container(
                    width: 350,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deal đa tầng - khao nước xịn đến 90k',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Áp dụng từ 2 voucher mỗi đơn',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 55,
                      alignment: Alignment.topCenter,
                      child: const Image(
                        image: AssetImage('images/hinh_82.png'),
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 250,
            width: double.infinity,
            child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance.collection('nhaHang').get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                List<NhaHang> restaurantList = snapshot.data!.docs
                    .map((DocumentSnapshot<Map<String, dynamic>> doc) {
                  return NhaHang.fromSnapshot(doc);
                }).toList();

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurantList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var restaurant = restaurantList[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => chiTietNhaHangPage(
                              IDNhaHang: restaurant.IDNhaHang,
                              tenNH: restaurant.tenNH,
                              anhDaiDienNH: restaurant.anhDaiDienNH,
                              diaChiNH: restaurant.diaChiNH,
                              khoangCach: restaurant.khoangCach,
                              danhGia: restaurant.danhGia,
                              SLDaBan: restaurant.SLDaBan,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        margin: const EdgeInsets.only(right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            restaurant.anhDaiDienNH.isNotEmpty
                                ? Container(
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image:
                                            AssetImage(restaurant.anhDaiDienNH),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromARGB(255, 230, 149, 144),
                                    ),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              restaurant.tenNH,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Image(
                                  image: AssetImage('images/hinh_72.png'),
                                  width: 25,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: restaurant.danhGia.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' (${restaurant.SLDaBan}+)',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
