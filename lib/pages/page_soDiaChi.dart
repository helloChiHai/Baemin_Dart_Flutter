import 'package:baemax/widgets/cardModalBottom.dart';
import 'package:baemax/widgets/soDiaChiItemDiaChiWidget.dart';
import 'package:flutter/material.dart';
import 'package:baemax/modal/diaChiLuu.dart';

class SoDiaChiPage extends StatefulWidget {
  SoDiaChiPage({Key? key}) : super(key: key);

  @override
  State<SoDiaChiPage> createState() => _SoDiaChiPageState();
}

class _SoDiaChiPageState extends State<SoDiaChiPage> {
  final List<diaChiLuus> items = [
    diaChiLuus(
      id: 'DC1',
      ten: 'Nhà',
      diaChi: 'Lưu địa chỉ',
      ghiChu: 'Ghi chú 1',
    ),
    diaChiLuus(
      id: 'DC2',
      ten: 'Công ty',
      diaChi: 'Lưu địa chỉ',
      ghiChu: 'Ghi chú 2',
    ),
  ];

  void _handleAddLocationTask(String ten, String diaChi, String ghiChu) {
    final newItem = diaChiLuus(
      id: DateTime.now().toString(),
      ten: ten,
      diaChi: diaChi,
      ghiChu: ghiChu,
    );

    // cập nhật lại dữ liệu khi có dữ liệu mới hoặc dữ liệu bị thay đổi
    setState(() {
      items.add(newItem);
    });
  }

  void _handleUpdateLocation(diaChiLuus updatedItem) {
    setState(() {
      final index = items.indexWhere((item) => item.id == updatedItem.id);
      if (index != -1) {
        items[index] = updatedItem;
      }
    });
  }

  void _handleDeleteLocation(String id) {
    setState(() {
      items.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Danh sách địa chỉ',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Địa điểm của tôi',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    child: Text(
                      '${items.length} / 5',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: items
                    .map((item) => soDiaChi_ItemDiaChi(
                          item: item,
                          onUpdate: _handleUpdateLocation,
                          onDelete: _handleDeleteLocation,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: items.length > 4
          ? null
          : FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.grey[200],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  // isScrollControlled: true, -> xoay màn hình ngang có thể hiển thị dược modal
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return ModalBottom(
                      addTask: (String ten, String diaChi, String ghiChu) {
                        _handleAddLocationTask(ten, diaChi, ghiChu);
                      },
                    );
                  },
                );
              },
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
    );
  }
}
