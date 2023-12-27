import 'package:flutter/material.dart';

class danhMucVaCuaHangListNhaHang extends StatefulWidget {
  final ValueChanged<int> onCheckboxCountChanged;
  final Function(String, String) onItemSelected;
  late String initialIndexSelectedItem;

  danhMucVaCuaHangListNhaHang({
    Key? key,
    required this.onCheckboxCountChanged,
    required this.onItemSelected,
    required this.initialIndexSelectedItem,
  }) : super(key: key);

  @override
  State<danhMucVaCuaHangListNhaHang> createState() =>
      _danhMucVaCuaHangListNhaHangState();
}

class _danhMucVaCuaHangListNhaHangState
    extends State<danhMucVaCuaHangListNhaHang> {
  String? chonCuaHang;
  List<String> checkBoxTexts = [
    'Trà / Cà phê',
    'Trà sữa',
    'Sinh tố / Nước ép / Sữa',
    'Sữa chua trân châu',
    'Ăn vặt',
    'Sald / Thực phẩm bổ dưỡng',
    'Cơm - Cơm tấm',
    'Cơm - Các loại khác',
    'Bánh mì / Xôi',
    'Mỳ / Cháo / Bún / Phở',
    'Pizza',
    'Đồ ăn nhanh',
    'Món truyền thống / Đặc sản',
    'Cá/ Ốc / Hải sản',
    'Lẩu / Nướng',
    'Đồ ăn nước ngoài',
    'Tráng miệng',
  ];
  late List<bool> isCheckedListCheck;
  List<bool> shouldCancelSelection = List.generate(17, (index) => false);
  bool kiemTraNhanCheckButtons = false;
  bool shouldPop = true; // biến cờ để kiểm tra xem có nên pop về hay không

  String nhanViTriDMCH = '';

  @override
  void initState() {
    super.initState();
    nhanViTriDMCH += widget.initialIndexSelectedItem;
    isCheckedListCheck = List.generate(17, (index) => false);

    List<String> indexList = nhanViTriDMCH.split(' ');
    for (String index in indexList) {
      int? parsedIndex = int.tryParse(index);
      if (parsedIndex != null &&
          parsedIndex >= 0 &&
          parsedIndex < isCheckedListCheck.length) {
        isCheckedListCheck[parsedIndex] = true;
      }
    }
  }

  void onItemSelected(String selectedItem, String indexSelectedItem) {
    widget.onItemSelected(selectedItem, indexSelectedItem);
    print('selected item: $selectedItem - $indexSelectedItem');
  }

  void capNhatSoluongCheckBoxDuocChon() {
    int dem = isCheckedListCheck.where((isChecked) => isChecked).length;
    widget.onCheckboxCountChanged(dem);
    setState(() {
      kiemTraNhanCheckButtons = dem > 0;
    });
  }

  void xoaTatCaLuaChon() {
    setState(() {
      isCheckedListCheck = List<bool>.filled(isCheckedListCheck.length, false);
      nhanViTriDMCH = '';
      widget.initialIndexSelectedItem = '';
      capNhatSoluongCheckBoxDuocChon();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Danh mục & cửa hàng',
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
              String selectedIndices = ' ';
              for (int i = 0; i < isCheckedListCheck.length; i++) {
                if (isCheckedListCheck[i]) {
                  selectedIndices += '$i';
                }
              }
              Navigator.pop(context, selectedIndices);
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          children: [
            Container(
              height: 670,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nhanViTriDMCH,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      'Cửa hàng',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    RadioListTile(
                      title: const Text(
                        'Mart',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      value: 'mart',
                      groupValue: chonCuaHang,
                      controlAffinity: ListTileControlAffinity.trailing,
                      onChanged: (value) {
                        setState(() {
                          chonCuaHang = value.toString();
                          print(chonCuaHang);
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text(
                        'BAEMAX Kitchen',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      value: 'baemaxkitchen',
                      controlAffinity: ListTileControlAffinity.trailing,
                      groupValue: chonCuaHang,
                      onChanged: (value) {
                        setState(() {
                          chonCuaHang = value.toString();
                          print(chonCuaHang);
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 1,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Text(
                      'Danh mục',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    for (int i = 0; i < checkBoxTexts.length; i++)
                      CheckboxListTile(
                        title: Text(
                          checkBoxTexts[i],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        value: isCheckedListCheck[i],
                        onChanged: (bool? value) {
                          if (value != null) {
                            setState(() {
                              if (isCheckedListCheck[i] &&
                                  !shouldCancelSelection[i]) {
                                isCheckedListCheck[i] = false;
                                shouldCancelSelection[i] = true;
                              } else {
                                isCheckedListCheck[i] = value;
                                shouldCancelSelection[i] = false;
                                capNhatSoluongCheckBoxDuocChon();
                              }
                            });
                            onItemSelected(
                                checkBoxTexts[i].toString(), i.toString());
                            if (isCheckedListCheck[i] &&
                                !shouldCancelSelection[i]) {
                              Navigator.pop(context);
                            }
                          }
                        },
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: kiemTraNhanCheckButtons ? Colors.black : Colors.grey,
                  ),
                ),
                child: TextButton(
                  onPressed: xoaTatCaLuaChon,
                  child: Text(
                    'Bỏ lựa chọn',
                    style: TextStyle(
                      fontSize: 20,
                      color:
                          kiemTraNhanCheckButtons ? Colors.black : Colors.grey,
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
