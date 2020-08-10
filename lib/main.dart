import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  var _qualityUnit = 1.0;
  var _concentrationUnit = 1.0;
  var _sizeUnit = 1.0;

  TextEditingController _qualityController = TextEditingController();
  TextEditingController _concentrationController = TextEditingController();
  TextEditingController _sizeController = TextEditingController();
  TextEditingController _molecularController = TextEditingController();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    height: 70,
                    child: TextField(
                        controller: _qualityController,
                        keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            labelText: "质量",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)))),
                  ),
                  DropdownButton(
                    value: _qualityUnit,
                    items: _quatityPickList,
                    underline: Container(height: 0),
                    onChanged: (value) {
                      setState(() {
                        _qualityUnit = value;
                      });
                    },
                  ),
                  Text("  =  ")
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      height: 70,
                      child: TextField(
                          controller: _concentrationController,
                          keyboardType: TextInputType.numberWithOptions(),
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              labelText: "浓度",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)))),
                    ),
                    DropdownButton(
                      value: _concentrationUnit,
                      items: _concentrationPickList,
                      underline: Container(height: 0),
                      onChanged: (value) {
                        setState(() {
                          _concentrationUnit = value;
                        });
                      },
                    ),
                    Text(" *  ")
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      height: 70,
                      child: TextField(
                          controller: _sizeController,
                          keyboardType: TextInputType.numberWithOptions(),
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              labelText: "体积",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)))),
                    ),
                    DropdownButton(
                      value: _sizeUnit,
                      items: _sizePickList,
                      underline: Container(height: 0),
                      onChanged: (value) {
                        setState(() {
                          _sizeUnit = value;
                        });
                      },
                    ),
                    Text("  *  ")
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    height: 70,
                    child: TextField(
                        controller: _molecularController,
                        keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            labelText: "分子量",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)))),
                  ),
                ],
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

  double getConcentrationUnit() {
    double result = 1.0;
    if (_concentrationUnit == "fM") {
      result = 0.000000001;
    } else if (_qualityUnit == "ng") {}

    return result;
  }

  void calculate() {
    bool e1 = _qualityController.text.isEmpty;
    bool e2 = _concentrationController.text.isEmpty;
    bool e3 = _sizeController.text.isEmpty;
    bool e4 = _molecularController.text.isEmpty;
    if (e4) {
      showToast("分子量不能为空");
      return;
    }
    double quality = string2Num(_qualityController.text) * _qualityUnit;
    double concentration =
        string2Num(_concentrationController.text.toString()) *
            _concentrationUnit;
    double size = string2Num(_sizeController.text.toString()) * _sizeUnit;
    double molecular = string2Num(_molecularController.text.toString());
    if (!e2 && !e3 && !e4) {
      double q = concentration * size * molecular / _qualityUnit;
      _qualityController.text = q.toString();
    } else if (!e1 && e2 && !e3 && !e4) {
      double c = quality / size / molecular / _concentrationUnit;
      _concentrationController.text = c.toString();
    } else if (!e1 && !e2 && e3 && !e4) {
      double s = quality / concentration / molecular / _sizeUnit;
      _sizeController.text = s.toString();
    } else {
      showToast("参数不足");
    }
  }
}
