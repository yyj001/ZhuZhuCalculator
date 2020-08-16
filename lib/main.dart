import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zhuzhu_calculator/myWitget/ColorBackground.dart';
import 'package:zhuzhu_calculator/myWitget/MyKeyBoard.dart';

List<DropdownMenuItem<double>> _quatityPickList = [
  DropdownMenuItem(value: 0.000000001, child: Text('pg')),
  DropdownMenuItem(value: 0.000001, child: Text('ng')),
  DropdownMenuItem(value: 0.001, child: Text('ug')),
  DropdownMenuItem(value: 1.0, child: Text('mg')),
  DropdownMenuItem(value: 1000.0, child: Text('g')),
  DropdownMenuItem(value: 1000000.0, child: Text('kg')),
];

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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.white),
      home: MyHomePage(title: '摩尔浓度计算器'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  TabController _tabController;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<EditTextState> _qualityKey = GlobalKey();
  GlobalKey<EditTextState> _concentrationKey = GlobalKey();
  GlobalKey<EditTextState> _sizeKey = GlobalKey();
  GlobalKey<EditTextState> _molecularKey = GlobalKey();

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
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          elevation: 0.5,
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
                              "计算公式：质量 (mg) = 浓度 (mM) x 体积 (mL) x 分子量 (g/mol)",
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black45),
                            ),
                          )
                        ]),
                    EditText(
                      key: _qualityKey,
                      list: _quatityPickList,
                      hint: "质量",
                      isSelected: _selectIndex == 0,
                      onTap: () {
                        setState(() {
                          _selectIndex = 0;
                        });
                      },
                      icon: "images/quality.png",
                    ),
                    EditText(
                      key: _concentrationKey,
                      list: _concentrationPickList,
                      hint: "浓度",
                      isSelected: _selectIndex == 1,
                      onTap: () {
                        setState(() {
                          _selectIndex = 1;
                        });
                      },
                      icon: "images/concentration.png",
                    ),
                    EditText(
                      key: _sizeKey,
                      list: _sizePickList,
                      hint: "体积",
                      isSelected: _selectIndex == 2,
                      onTap: () {
                        setState(() {
                          _selectIndex = 2;
                        });
                      },
                      icon: "images/size.png",
                    ),
                    EditText(
                      key: _molecularKey,
                      hint: "分子量",
                      isSelected: _selectIndex == 3,
                      onTap: () {
                        setState(() {
                          _selectIndex = 3;
                        });
                      },
                      icon: "images/molecularKey.png",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 300,
                            height: 50,
                            padding: EdgeInsets.fromLTRB(0, 0, 18, 0),
                            child: RaisedButton(
                                color: Colors.blue,
                                child: Text("计算"),
                                onPressed: calculate))
                      ],
                    )
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
            Align(alignment: Alignment.bottomCenter, child: MyKeyBoard()),
          ],
        ));
  }

  double string2Num(String s) {
    if (s.isEmpty) {
      return 0.0;
    }
    return double.parse(s);
  }

  void showToast(String tips) {
    Fluttertoast.showToast(
        msg: tips,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        textColor: Colors.black87);
  }

  void calculate() {
    bool e1 = _qualityKey.currentState.controller.text.isEmpty;
    bool e2 = _concentrationKey.currentState.controller.text.isEmpty;
    bool e3 = _sizeKey.currentState.controller.text.isEmpty;
    bool e4 = _molecularKey.currentState.controller.text.isEmpty;
    if (e4) {
      showToast("分子量不能为空");
      return;
    }
    double quality = string2Num(_qualityKey.currentState.controller.text) *
        _qualityKey.currentState.unit;
    double concentration =
        string2Num(_concentrationKey.currentState.controller.text.toString()) *
            _concentrationKey.currentState.unit;
    double size = string2Num(_sizeKey.currentState.controller.text.toString()) *
        _sizeKey.currentState.unit;
    double molecular =
        string2Num(_molecularKey.currentState.controller.text.toString());
    if (!e2 && !e3 && !e4) {
      double q =
          concentration * size * molecular / _qualityKey.currentState.unit;
      _qualityKey.currentState.controller.text = q.toString();
    } else if (!e1 && e2 && !e3 && !e4) {
      double c =
          quality / size / molecular / _concentrationKey.currentState.unit;
      _concentrationKey.currentState.controller.text = c.toString();
    } else if (!e1 && !e2 && e3 && !e4) {
      double s =
          quality / concentration / molecular / _sizeKey.currentState.unit;
      _sizeKey.currentState.controller.text = s.toString();
    } else {
      showToast("参数不足");
    }
  }
}
