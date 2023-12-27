import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class timKiemDiaChiPage extends StatefulWidget {
  const timKiemDiaChiPage({Key? key, required this.onLocationSelected})
      : super(key: key);

  final Function(String) onLocationSelected;

  @override
  State<timKiemDiaChiPage> createState() => _timKiemDiaChiPageState();
}

class _timKiemDiaChiPageState extends State<timKiemDiaChiPage> {
  TextEditingController textController = TextEditingController();
  bool showClearButton = false;
  List<dynamic> locations = [];

  void clearText() {
    setState(() {
      textController.clear();
      showClearButton = false;
      locations.clear();
    });
  }

  void printLocationInfo(dynamic location) {
    print('Location: ${location['display_name']}');
    // print('Type: ${location['type']}');
    // In ra các thông tin khác của location nếu cần
  }

  Future<void> searchCities(String query) async {
    final apiUrl =
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=8&countrycodes=VN';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (mounted) {
        setState(() {
          locations = data;
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Lỗi'),
            content: Text('Không thể tìm kiếm địa chỉ.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Sửa địa chỉ',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 25,
                    child: const Image(
                      image: AssetImage(
                        'images/hinh_36.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textController,
                              onChanged: (value) {
                                setState(() {
                                  showClearButton = value.isNotEmpty;
                                  searchCities(value);
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Địa chỉ hiện tại của bạn ở đâu',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: showClearButton,
                            child: IconButton(
                              onPressed: clearText,
                              icon: const Icon(
                                Icons.clear,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('object');
                    },
                    child: Container(
                      width: 25,
                      child: const Image(
                        image: AssetImage(
                          'images/hinh_75.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location = locations[index];
                return ListTile(
                  title: Text(location['display_name']),
                  // subtitle: Text(location['type']),
                  onTap: () {
                    printLocationInfo(location);
                    // Navigator.pop(context, location['display_name']);
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'Bạn có chắc là chổ này',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        content: Text(location['display_name']),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, null),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, location['display_name']);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ).then((value) {
                      if (value != null) {
                        // goi ham callback va truyen gia tri dia chi duoc chon
                        widget.onLocationSelected(value);
                      }
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
