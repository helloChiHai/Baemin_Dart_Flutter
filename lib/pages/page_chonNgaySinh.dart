import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class chonNgaySinhPage extends StatefulWidget {
  final String idCuaNguoiDung;

  const chonNgaySinhPage({
    Key? key,
    required this.idCuaNguoiDung,
  }) : super(key: key);

  @override
  _chonNgaySinhPageState createState() => _chonNgaySinhPageState();
}

class _chonNgaySinhPageState extends State<chonNgaySinhPage> {
  DateTime _selectedDate = DateTime.now();

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  String IDnguoiDung = '';

 @override
  void initState() {
    super.initState();
    IDnguoiDung = widget.idCuaNguoiDung;
  }

    Future<void> capNhatNgaySinhNguoiDungTheoID(String newUserNgaySinh) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('khachHang')
          .where('idKH', isEqualTo: IDnguoiDung)
          .limit(1)
          .get();

      if (snapshot.size > 0) {
        final khachHangID = snapshot.docs[0].id;
        await FirebaseFirestore.instance
            .collection('khachHang')
            .doc(khachHangID)
            .update({'ngaySinh': newUserNgaySinh});

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ngày sinh đã được cập nhật thành công.'),
        ));
      }
    } catch (e) {
      print('Loi cap nhat ten: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Đã xảy ra lỗi khi cập nhật ngày sinh.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Ngày sinh',
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Để BAEMAX nhớ ngày sinh nhật bạn nè',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                _dateFormat.format(_selectedDate),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: ()async{
                     capNhatNgaySinhNguoiDungTheoID(_dateFormat.format(_selectedDate));
                    },
                    child: const Text(
                      'Lưu',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 48),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _selectedDate = DateTime.now();
                  });
                },
                child: const Text(
                  "Hôm nay",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            SizedBox(
              height: 250,
              child: ScrollDatePicker(
                selectedDate: _selectedDate,
                locale: Locale('vi'),
                scrollViewOptions: const DatePickerScrollViewOptions(
                  year: ScrollViewDetailOptions(
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                    selectedTextStyle: TextStyle(
                      fontSize: 20,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                  ),
                  month: ScrollViewDetailOptions(
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                    selectedTextStyle: TextStyle(
                      fontSize: 20,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                  ),
                  day: ScrollViewDetailOptions(
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                    selectedTextStyle: TextStyle(
                      fontSize: 20,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                  ),
                ),
                onDateTimeChanged: (DateTime value) {
                  setState(
                    () {
                      _selectedDate = value;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
