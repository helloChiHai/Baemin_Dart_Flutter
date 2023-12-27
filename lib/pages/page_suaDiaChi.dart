import 'package:baemax/modal/diaChiLuu.dart';
import 'package:flutter/material.dart';
import 'package:baemax/pages/page_timKiemDiaChi.dart';

class SuaDiaChiPage extends StatefulWidget {
  const SuaDiaChiPage({Key? key, required this.item}) : super(key: key);

  final dynamic item;

  @override
  _SuaDiaChiPageState createState() => _SuaDiaChiPageState();
}

class _SuaDiaChiPageState extends State<SuaDiaChiPage> {
  TextEditingController tenController = TextEditingController();
  TextEditingController diaChiController = TextEditingController();
  TextEditingController ghiChuController = TextEditingController();

  void _handleLocationSelected(String location) {
    setState(() {
      diaChiController.text = location;
    });
  }

  void _handleUpdateLoction() {
    final updateItem = diaChiLuus(
      id: widget.item.id,
      ten: tenController.text,
      diaChi: diaChiController.text,
      ghiChu: ghiChuController.text,
    );

    Navigator.pop(context, updateItem);
  }

  void _handleDeleteLocation() {
    String deletedItemId = widget.item.id;
    Navigator.pop(context, deletedItemId);
  }

  int checkIDLocation() {
    if (widget.item.id == 'DC1' || widget.item.id == 'DC2') {
      return 1;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    tenController.text = widget.item.ten;
    diaChiController.text = widget.item.diaChi;
    ghiChuController.text = widget.item.ghiChu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Sửa địa chỉ',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          size: 30,
          color: Colors.black,
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
              'Tên *',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 96, 92, 92),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: tenController,
              decoration: InputDecoration(
                hintText: 'Vd: Trường học, Phòng tập',
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                final diaChiDuocChon = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => timKiemDiaChiPage(
                      onLocationSelected: _handleLocationSelected,
                    ),
                  ),
                );
                if (diaChiDuocChon != null) {
                  setState(() {
                    diaChiController.text = diaChiDuocChon;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Địa chỉ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 96, 92, 92),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            enabled: false,
                            controller: diaChiController,
                            decoration: const InputDecoration(
                              hintText: 'Địa chỉ',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      '>',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Ghi chú',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 96, 92, 92),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: ghiChuController,
              decoration: const InputDecoration(
                hintText: 'Ghi chú (tùy chọn)',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 25,
            ),

            // checkIDLocation() == 0
            //     ? GestureDetector(
            //         onTap: () {
            //           showDialog<String>(
            //             context: context,
            //             builder: (BuildContext context) => AlertDialog(
            //               title: const Text(
            //                 'Xóa địa chỉ này?',
            //                 style: TextStyle(
            //                   fontSize: 22,
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //               content: const Text(
            //                 'Bạn có chắc bạn muốn xóa địa chỉ này?',
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   color: Colors.black,
            //                 ),
            //               ),
            //               actions: [
            //                 TextButton(
            //                   onPressed: () => Navigator.pop(context),
            //                   child: const Text(
            //                     'HỦY',
            //                     style: TextStyle(
            //                       fontSize: 17,
            //                       color: Color.fromARGB(255, 2, 72, 63),
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                 ),
            //                 TextButton(
            //                   onPressed: (){
            //                     _handleDeleteLocation();
            //                   },
            //                   child: const Text(
            //                     'OK',
            //                     style: TextStyle(
            //                       fontSize: 17,
            //                       color: Color.fromARGB(255, 2, 72, 63),
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //         },
            //         child: Container(
            //           width: 170,
            //           height: 35,
            //           child: const Row(
            //             children: [
            //               Icon(
            //                 Icons.delete_forever_outlined,
            //                 size: 28,
            //                 color: Colors.red,
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Text(
            //                 'Xóa địa chỉ này',
            //                 style: TextStyle(
            //                   fontSize: 18,
            //                   color: Colors.red,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       )
            //     : SizedBox(),
            checkIDLocation() == 0
                ? Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleDeleteLocation();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'xóa',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            // checkIDLocation() == 0
            //     ? Container(
            //         width: double.infinity,
            //         height: 50,
            //         child: ElevatedButton(
            //           onPressed: () {
            //             showDialog(
            //               context: context,
            //               builder: (context) {
            //                 return AlertDialog(
            //                   title: Text('Xóa'),
            //                   content: Text('Bạn có chắc chắn muốn xóa?'),
            //                   actions: [
            //                     TextButton(
            //                       onPressed: () {
            //                         Navigator.of(context).pop();//ng dialog khi nhấn Cancel
            //                       },
            //                       child: Text('Cancel'),
            //                     ),
            //                     TextButton(
            //                       onPressed: () {
            //                         Navigator.of(context).pop();
            //                       },
            //                       child: Text('OK'),
            //                     ),
            //                   ],
            //                 );
            //               },
            //             );
            //           },
            //           style: ElevatedButton.styleFrom(
            //             primary: Colors.blue,
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(10),
            //             ),
            //           ),
            //           child: const Text(
            //             'Xóa',
            //             style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ),
            //       )
            //     : SizedBox(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _handleUpdateLoction();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Lưu',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
