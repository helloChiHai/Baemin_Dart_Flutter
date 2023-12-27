import 'package:baemax/widgets/dealDaTang_KhaoNuocXin.dart';
import 'package:baemax/widgets/dealdDaTan_KhaoMonAn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/User.dart';
import 'widgets/mainCarouselSukienWidget.dart';
import 'widgets/mainHeaderWidget.dart';
import 'widgets/mainLuaChonTheoLoaiWidget.dart';
import 'widgets/mainTimKiemWidget.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => User(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            color: Colors.grey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  main_header_widget(),
                  main_search_widget(),
                  main_carousel_suKien_widget(),
                  main_luaChonTheoLoai_widget(),
                  khaoNuocXin_DealDaTang(),
                  khaoMonAn_DealDaTang(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
