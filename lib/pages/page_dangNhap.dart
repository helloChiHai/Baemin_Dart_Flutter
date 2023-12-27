import 'package:baemax/pages/page_suaThongTin_SDT.dart';
import 'package:flutter/material.dart';

class dangNhapPage extends StatelessWidget {
  const dangNhapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 212, 248, 251),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color.fromARGB(255, 212, 248, 251),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 420,
                height: 680,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(200),
                        topRight: Radius.circular(180))),
              ),
            ),
            Positioned(
              top: -150,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.transparent,
                child: const Image(
                  image: AssetImage('images/hinh_83.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              child: Container(
                margin: EdgeInsets.only(top: 250),
                color: Colors.transparent,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'BAEMAX NÓNG GIÒN ĐÂY NÈ!',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Hãy nhập số điện thoại để tiếp tục nhá!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => suaThongTin_SDT_Page()));
                      },
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        child: const Row(
                          children: [
                            Image(
                              image: AssetImage('images/hinh_57.png'),
                              width: 40,
                              height: 40,
                            ),
                            Text(
                              '+84 ',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '|',
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 250,
                                child: TextField(
                                  enabled: false,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Số điện thoại',
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 70),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Hoặc đăng nhập bằng',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Xin lỗi bạn nhiều'),
                              content: const Text(
                                'BaeMax đang phát triển tính năng này. Bạn vui lòng quay lại sau.',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        child: const Image(
                            image: AssetImage('images/hinh_84.png')),
                      ),
                    ),
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
