import 'package:flutter/material.dart';

class hopThuPage extends StatelessWidget {
  const hopThuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // loại bỏ đường viền shadow
        centerTitle: true,
        title: const Text(
          'Hộp thư',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          size: 30,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/hinh_55.png'),
                  fit: BoxFit.cover,
                  height: 180,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Đang hóng tin nhắn đầu tiên...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 SizedBox(
                  height: 10,
                ),
                Text(
                  'BAEMAX sẽ sớm trở lại, lợi hại hơn xưa!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
