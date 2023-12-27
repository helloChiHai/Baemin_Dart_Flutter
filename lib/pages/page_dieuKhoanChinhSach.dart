import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class dieuKhoanChinhSachPage extends StatefulWidget {
  const dieuKhoanChinhSachPage({super.key});

  @override
  State<dieuKhoanChinhSachPage> createState() => _dieuKhoanChinhSachPageState();
}

class _dieuKhoanChinhSachPageState extends State<dieuKhoanChinhSachPage> {
  String fileContent = '';

  @override
  void initState() {
    super.initState();
    loadAsset().then((value) {
      setState(() {
        fileContent = value;
      });
    });
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('fileText/dk_1.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5, // bỏ viền shadow
        centerTitle: true,
        title: const Text(
          'Điều khoản',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'điều khoản sử dụng',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'I. Những Quy Định Chung',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                fileContent,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
