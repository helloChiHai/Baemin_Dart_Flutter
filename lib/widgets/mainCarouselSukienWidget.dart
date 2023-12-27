import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class main_carousel_suKien_widget extends StatelessWidget {
  const main_carousel_suKien_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 200,
      child: CarouselSlider(
        items: [
          GestureDetector(
            onTap: () {
              // Xử lý khi người dùng nhấp vào item 1
              print('Item 1 được nhấp');
            },
            child: Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('images/hinh_42.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Xử lý khi người dùng nhấp vào item 2
              print('Item 2 được nhấp');
            },
            child: Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('images/hinh_43.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Xử lý khi người dùng nhấp vào item 3
              print('Item 3 được nhấp');
            },
            child: Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('images/hinh_44.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
        options: CarouselOptions(
          height: 200,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}
