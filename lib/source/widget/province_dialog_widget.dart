import 'package:flutter/material.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/models/province_model.dart';
import 'package:tiengviet/tiengviet.dart';

class ProvinceSelectDialog extends StatefulWidget {
  final Province provinceSelected;

  final List<Province> lstProvince;

  const ProvinceSelectDialog(
      {Key? key, required this.lstProvince, required this.provinceSelected})
      : super(key: key);

  @override
  State<ProvinceSelectDialog> createState() => _ProvinceSelectDialogState();
}

class _ProvinceSelectDialogState extends State<ProvinceSelectDialog> {
  late TextEditingController textEditingController;

  List<Province> lstFilterProvince = [];

  late Province _provinceSelected;
  @override
  void initState() {
    lstFilterProvince.addAll(widget.lstProvince);
    textEditingController = TextEditingController();
    _provinceSelected = widget.provinceSelected;
    super.initState();
    textEditingController.addListener(() {
      if (textEditingController.text.isNotEmpty) {
        onFilter(textEditingController.text);
      } else {
        onFilter(null);
      }
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  _onTapClear() {
    textEditingController.clear();
  }

  //Filter offline
  onFilter(String? value) {
    lstFilterProvince.clear();
    if (value == null) {
      lstFilterProvince.addAll(widget.lstProvince);
    } else {
      String _searchUnsigned = TiengViet.parse(value.toLowerCase());
      lstFilterProvince = widget.lstProvince.where((element) {
        String _titleUnsigned = TiengViet.parse(element.title!.toLowerCase());
        return _titleUnsigned.contains(_searchUnsigned);
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding:
          const EdgeInsets.only(top: 10, bottom: 10, left: 32, right: 8),
      child: Stack(
        // ignore: deprecated_member_use
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(right: 24.0, top: 40),
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              padding: const EdgeInsets.fromLTRB(10, 54, 10, 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 54,
                    // padding: const EdgeInsets.fromLTRB(20, 54, 20, 20),
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                          labelText: "Tìm kiếm tỉnh thành",
                          isDense: true,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: ThemePrimary.primaryColor),
                          hintText: "Nhập tỉnh thành cần tìm",
                          prefixIcon: Icon(
                            Icons.search,
                            color: ThemePrimary.primaryColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: _onTapClear,
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: ThemePrimary.primaryColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: ThemePrimary.primaryColor)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: ThemePrimary.primaryColor))),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        children: lstFilterProvince.map((e) {
                          bool _isSelected = _provinceSelected.id == e.id;
                          return InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              _provinceSelected = e;
                              Navigator.of(context).pop(_provinceSelected);
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    border: const Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.black12)),
                                    color: _isSelected
                                        ? ThemePrimary.primaryColor
                                        : Colors.white),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_city,
                                        color: _isSelected
                                            ? Colors.white
                                            : ThemePrimary.textPrimaryColor
                                                .withOpacity(0.5)),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      e.title!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: _isSelected
                                                  ? Colors.white
                                                  : ThemePrimary
                                                      .textPrimaryColor),
                                    ),
                                  ],
                                )),
                          );
                        }).toList()),
                  ),
                ],
              )),
          Positioned(
              top: 0,
              child: Container(
                  height: 80,
                  width: 80,
                  margin: const EdgeInsets.only(right: 24),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: ThemePrimary.primaryColor),
                  child: const Center(
                      child: Icon(
                    Icons.location_city,
                    color: Colors.white,
                    size: 48,
                  )))),
          Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Ink(
                  padding: const EdgeInsets.all(4.0),
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: const Icon(Icons.clear, color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
