import 'package:baemax/pages/page_timKiemDiaChi.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ModalBottom extends StatefulWidget {
  ModalBottom({Key? key, required this.addTask}) : super(key: key);

  final Function addTask;

  @override
  State<ModalBottom> createState() => _ModalBottomState();
}

class _ModalBottomState extends State<ModalBottom> {
  TextEditingController tenController = TextEditingController();
  TextEditingController diaChiController = TextEditingController();
  TextEditingController ghiChuController = TextEditingController();

  String tenDC = '';
  String diaChiDC = '';
  String ghiChuDC = '';

  void _handleOnclick(BuildContext context) {
    final ten = tenController.text;
    final diaChi = diaChiController.text;
    final ghiChu = ghiChuController.text;

    // nếu name rỗng thì không làm gì cả
    if (ten.isEmpty || ghiChu.isEmpty) {
      return;
    }
    widget.addTask(ten, diaChi, ghiChu);
    //  sau khi add thì chuyển về trang chủ
    Navigator.pop(context);
  }

  void _handleLocationSelected(String location) {
    setState(() {
      diaChiController.text = location;
    });
  }

  bool checkInForLocation(){
    if(tenDC.isEmpty || diaChiController.text.isEmpty || ghiChuDC.isEmpty){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Container(
              child: const Text(
                'Địa chỉ của bạn ở đâu dạaa',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: tenController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.black,
                  ),
                ),
                labelText: 'Tên',
              ),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              onChanged: (value) {
                setState(() {
                  tenDC = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
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
                      width: 370,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            enabled: false,
                            controller: diaChiController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Điều chỉnh độ cong của viền
                                borderSide: const BorderSide(
                                  width: 3.0, // Điều chỉnh độ dày của viền
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'Địa chỉ',
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            onChanged: (value) {
                              setState(() {
                                diaChiDC = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: ghiChuController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.black,
                  ),
                ),
                labelText: 'Ghi chú',
              ),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              onChanged: (value) {
                setState(() {
                  ghiChuDC = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: checkInForLocation()
                    ? null
                    : () => _handleOnclick(context),
                child: const Text(
                  'Thêm địa chỉ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
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
