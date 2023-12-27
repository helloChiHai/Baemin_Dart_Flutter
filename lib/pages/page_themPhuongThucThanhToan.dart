import 'package:flutter/material.dart';

class themPhuongThucThanhToanPage extends StatefulWidget {
  const themPhuongThucThanhToanPage({super.key});

  @override
  State<themPhuongThucThanhToanPage> createState() =>
      _themPhuongThucThanhToanPageState();
}

class _themPhuongThucThanhToanPageState
    extends State<themPhuongThucThanhToanPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Thêm phương thức thanh toán',
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
        leading: IconButton(
          icon: const Icon(Icons.close), // Thay đổi icon thành 'x'
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Thêm ví điện tử',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(
                  0xff555555,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 170,
              height: 125,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isChecked ? Colors.blue : Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('images/hinh_54.png'),
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ví MoMo',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isChecked
                        ? () {
                            print('đã nhấn vào thêm thanh toán');
                          }
                        : null,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Text(
                        'Xác nhận',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
