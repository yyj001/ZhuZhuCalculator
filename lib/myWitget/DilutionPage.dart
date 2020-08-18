import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vibrate/vibrate.dart';

import 'ColorBackground.dart';
import 'MyKeyBoard.dart';

List<DropdownMenuItem<double>> _concentrationPickList = [
  DropdownMenuItem(value: 0.000000000001, child: Text('fM')),
  DropdownMenuItem(value: 0.000000001, child: Text('pM')),
  DropdownMenuItem(value: 0.000001, child: Text('nM')),
  DropdownMenuItem(value: 0.001, child: Text('uM')),
  DropdownMenuItem(value: 1.0, child: Text('mM')),
  DropdownMenuItem(value: 1000.0, child: Text('M')),
];

List<DropdownMenuItem<double>> _sizePickList = [
  DropdownMenuItem(value: 0.000001, child: Text('nL')),
  DropdownMenuItem(value: 0.001, child: Text('uL')),
  DropdownMenuItem(value: 1.0, child: Text('mL')),
  DropdownMenuItem(value: 1000.0, child: Text('L')),
];

class DilutionPage extends StatefulWidget {
  DilutionPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DilutionPageState createState() => _DilutionPageState();
}

class _DilutionPageState extends State<DilutionPage> {
  GlobalKey<EditTextState> _concentrationKey1 = GlobalKey();
  GlobalKey<EditTextState> _concentrationKey2 = GlobalKey();
  GlobalKey<EditTextState> _sizeKey1 = GlobalKey();
  GlobalKey<EditTextState> _sizeKey2 = GlobalKey();

  int _selectIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  //页面销毁
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          elevation: 0.3,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              "计算公式：开始浓度 × 开始体积 = 最终浓度 × 最终体积",
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black45),
                            ),
                          )
                        ]),
                    EditText(
                      key: _sizeKey1,
                      list: _sizePickList,
                      hint: "开始体积",
                      isSelected: _selectIndex == 0,
                      onTap: () {
                        setState(() {
                          _selectIndex = 0;
                        });
                      },
                      icon: "images/size.png",
                    ),
                    EditText(
                      key: _concentrationKey1,
                      list: _concentrationPickList,
                      hint: "开始浓度",
                      isSelected: _selectIndex == 1,
                      onTap: () {
                        setState(() {
                          _selectIndex = 1;
                        });
                      },
                      icon: "images/concentration.png",
                    ),
                    EditText(
                      key: _sizeKey2,
                      list: _sizePickList,
                      hint: "最终体积",
                      isSelected: _selectIndex == 2,
                      onTap: () {
                        setState(() {
                          _selectIndex = 2;
                        });
                      },
                      icon: "images/size.png",
                    ),
                    EditText(
                      key: _concentrationKey2,
                      list: _concentrationPickList,
                      hint: "最终浓度",
                      isSelected: _selectIndex == 3,
                      onTap: () {
                        setState(() {
                          _selectIndex = 3;
                        });
                      },
                      icon: "images/concentration.png",
                    ),
                  ],
                ),
              ),
            ),
            // 解决全面屏底部颜色空间隙
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Color.fromARGB(0xff, 0x2a, 0x31, 0x38),
                )),
            Align(
                alignment: Alignment.bottomCenter,
                child: MyKeyBoard(
                  onClick: (String s) => addNumString(s),
                  onDelete: (String s) => onDelete(false),
                  onDeleteAll: () => onDelete(true),
                  onFinish: () => calculate(),
                  onMove: (bool isUp) => onMove(isUp),
                )),
          ],
        ));
  }

  void onMove(bool isUp) {
    setState(() {
      if (isUp) {
        _selectIndex--;
        if (_selectIndex < 0) {
          _selectIndex = 3;
        }
      } else {
        _selectIndex++;
        if (_selectIndex > 3) {
          _selectIndex = 0;
        }
      }
    });
  }

  void onDelete(bool isDeleteAll) {
    TextEditingController controller = getCurrentTextController();
    int extentOffset = controller.selection.extentOffset;
    String s1 = controller.text.substring(0, extentOffset - 1);
    String s2 = controller.text.substring(extentOffset);
    if (extentOffset <= 0) {
      return;
    }
    String finalValue = "";
    int finalIndex = 0;
    if (controller == null) {
      return;
    }
    if (isDeleteAll) {
      finalValue = s2;
      finalIndex = 0;
    } else {
      finalValue = s1 + s2;
      finalIndex = s1.length;
    }
    controller.value = TextEditingValue(
        text: finalValue,
        selection: controller.selection
            .copyWith(baseOffset: finalIndex, extentOffset: finalIndex));
  }

  TextEditingController getCurrentTextController() {
    TextEditingController controller =
        _concentrationKey1.currentState.controller;
    if (_selectIndex == 0) {
      controller = _sizeKey1.currentState.controller;
    } else if (_selectIndex == 1) {
      controller = _concentrationKey1.currentState.controller;
    } else if (_selectIndex == 2) {
      controller = _sizeKey2.currentState.controller;
    } else if (_selectIndex == 3) {
      controller = _concentrationKey2.currentState.controller;
    } else {
      controller = null;
    }
    return controller;
  }

  void addNumString(String s) {
    TextEditingController controller = getCurrentTextController();
    if (controller == null) {
      return;
    }
    int extentOffset = controller.selection.extentOffset;
    String s1 = controller.text.substring(0, extentOffset);
    String s2 = controller.text.substring(extentOffset);
    String finalValue = s1 + s + s2;
    int finalIndex = (s1 + s).length;

    controller.value = TextEditingValue(
        text: finalValue,
        selection: controller.selection
            .copyWith(baseOffset: finalIndex, extentOffset: finalIndex));
  }

  double string2Num(String s) {
    if (s.isEmpty) {
      return 0.0;
    }
    return double.parse(s);
  }

  void showToast(String tips) {
    var _type = FeedbackType.medium;
    Vibrate.feedback(_type);
    Fluttertoast.showToast(
      msg: tips,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
    );
  }

  void calculate() {
    bool e1 = _concentrationKey1.currentState.controller.text.isEmpty;
    bool e3 = _concentrationKey2.currentState.controller.text.isEmpty;
    bool e4 = _sizeKey2.currentState.controller.text.isEmpty;
    double c1 = string2Num(_concentrationKey1.currentState.controller.text) *
        _concentrationKey1.currentState.unit;
    double c2 =
        string2Num(_concentrationKey2.currentState.controller.text.toString()) *
            _concentrationKey2.currentState.unit;
    double s2 = string2Num(_sizeKey2.currentState.controller.text.toString()) *
        _sizeKey2.currentState.unit;
    if (!e1 && !e3 && !e4) {
      double value = c2 * s2 / c1;
      _sizeKey1.currentState.controller.text = value.toString();
    } else {
      showToast("参数不足");
    }
  }
}
