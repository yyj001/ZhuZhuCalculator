import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zhuzhu_calculator/myWitget/ColorBackground.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '摩尔浓度计算器'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<EditTextState> _qualityKey = GlobalKey();
  GlobalKey<EditTextState> _concentrationKey = GlobalKey();
  GlobalKey<EditTextState> _sizeKey = GlobalKey();
  GlobalKey<EditTextState> _molecularKey = GlobalKey();

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  List<Color> _colors = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent
  ];
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _focusNodes.length; ++i) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          setFocus(i);
        }
      });
    }
  }

  //页面销毁
  @override
  void dispose() {
    super.dispose();
    _focusNodes.forEach((f) {
      f.dispose();
    });
  }

  void setFocus(int index) {
    setState(() {
      _colors[_selectIndex] = Colors.transparent;
      _selectIndex = index;
      _colors[_selectIndex] = Colors.black;
      print("yyj" + _colors[0].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "计算公式：质量 (mg) = 浓度 (mM) x 体积 (mL) x 分子量 (g/mol)",
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold),
                    )
                  ]),
              EditText(key: _qualityKey, list:_quatityPickList, hint: "质量",),
              EditText(key: _concentrationKey, list:_concentrationPickList, hint: "浓度",),
              EditText(key: _sizeKey, list:_sizePickList, hint: "体积",),
              EditText(key: _molecularKey, hint: "分子量",),
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
    double quality = string2Num(_qualityKey.currentState.controller.text) * _qualityKey.currentState.unit;
    double concentration =
        string2Num(_concentrationKey.currentState.controller.text.toString()) *
            _concentrationKey.currentState.unit;
    double size = string2Num(_sizeKey.currentState.controller.text.toString()) * _sizeKey.currentState.unit;
    double molecular = string2Num(_molecularKey.currentState.controller.text.toString());
    if (!e2 && !e3 && !e4) {
      double q = concentration * size * molecular / _qualityKey.currentState.unit;
      _qualityKey.currentState.controller.text = q.toString();
    } else if (!e1 && e2 && !e3 && !e4) {
      double c = quality / size / molecular / _concentrationKey.currentState.unit;
      _concentrationKey.currentState.controller.text = c.toString();
    } else if (!e1 && !e2 && e3 && !e4) {
      double s = quality / concentration / molecular / _sizeKey.currentState.unit;
      _sizeKey.currentState.controller.text = s.toString();
    } else {
      showToast("参数不足");
    }
  }
}
