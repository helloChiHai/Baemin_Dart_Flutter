import 'package:baemax/modal/diaChiLuu.dart';
import 'package:baemax/pages/page_suaDiaChi.dart';
import 'package:flutter/material.dart';

class soDiaChi_ItemDiaChi extends StatefulWidget {
  soDiaChi_ItemDiaChi(
      {Key? key,
      required this.item,
      required this.onUpdate,
      required this.onDelete})
      : super(key: key);

  var item;
  final Function(diaChiLuus) onUpdate;
  final Function onDelete;

  @override
  State<soDiaChi_ItemDiaChi> createState() => _soDiaChi_ItemDiaChiState();
}

class _soDiaChi_ItemDiaChiState extends State<soDiaChi_ItemDiaChi> {
  String getImagePath() {
    if (widget.item.id == 'DC1') {
      return 'images/hinh_48.png';
    } else if (widget.item.id == 'DC2') {
      return 'images/hinh_58.png';
    } else {
      return 'images/hinh_50.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final updatedOrDeletedItem = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuaDiaChiPage(item: widget.item),
          ),
        );
        if (updatedOrDeletedItem != null) {
          if (updatedOrDeletedItem is String) {
            String itemId = updatedOrDeletedItem;
            widget.onDelete(itemId);
          } else if (updatedOrDeletedItem is diaChiLuus) {
            diaChiLuus updatedItem = updatedOrDeletedItem;
            widget.onUpdate(updatedItem);
          }
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              child: Image(
                image: AssetImage(getImagePath()),
                fit: BoxFit.cover,
                width: 35,
                height: 35,
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            Container(
              width: 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.ten,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Text(
                    widget.item.diaChi,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: const Text(
                  '>',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
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