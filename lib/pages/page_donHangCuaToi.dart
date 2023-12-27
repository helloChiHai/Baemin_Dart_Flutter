import 'package:flutter/material.dart';

class donHangCuaToiPage extends StatelessWidget {
  const donHangCuaToiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Đơn hàng của tôi',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: Color(0xffF8F8FF),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Đơn hàng trước',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 96, 92, 92),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('Bạn đã click vào xem chi tiết đơn hàng');
              },
              child: Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image(
                          image: AssetImage('images/hinh_28.png'),
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Đã giao',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 96, 92, 92),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          '21, tháng 6',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 96, 92, 92),
                          ),
                        ),
                      ],
                    ),
                   const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        'Gani - Cơm gà - Mì Trộn - 15/34 Cầu xéo HCM',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        //overflow: TextOverflow.ellipsis, -> để hiển thị dấu ... khi text vượt quá kích
                        // của contaienr
                        overflow: TextOverflow.ellipsis,
                        // maxLines: 1, -> hiển thị 1 dòng văn bản
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          '29.000 đ (Tiền mặt)',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 96, 92, 92),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          '1 Món',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 96, 92, 92),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 1,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(onPressed: () {
                      print('bạn đã nhấn và đặt lại');
                    }, child: const Text(
                      'Đặt lại',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.blue,
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
