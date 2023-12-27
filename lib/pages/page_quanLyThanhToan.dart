import 'package:baemax/pages/page_themPhuongThucThanhToan.dart';
import 'package:flutter/material.dart';

class quanLyThanhToanPage extends StatelessWidget {
  const quanLyThanhToanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: const Text(
          'Quản lý thanh toán',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: Container(
        height: double.infinity,
        color: const Color(0xffF8F8FF),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('images/hinh_51.png'),
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Chưa có thông tin thẻ lưu',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Lưu thông tin thẻ để thanh toán nhanh hơn nha!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => themPhuongThucThanhToanPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 1,
                      color: Color(0xff33FFFF),
                    ),
                    backgroundColor: const Color(0xffF8F8FF)),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Thêm phương thức thanh toán',
                    style: TextStyle(
                      color: Color(0xff0099FF),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
