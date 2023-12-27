
import 'package:flutter/material.dart';

class main_search_widget extends StatelessWidget {
  const main_search_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: ElevatedButton(
        onPressed: () {
          print('nhấn vào nút search');
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Colors.white), // Màu nền trắng
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20), // Bán kính bo góc 20
            ),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Image(
                image: AssetImage('images/hinh_36.png'),
                width: 20,
                height: 20,
                color: Colors.grey,
              ),
            ),
            Text(
              'Tìm cửa hàng hay sản phẩm',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}