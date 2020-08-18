import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:vibrate/vibrate.dart";

class MyKeyBoard extends StatefulWidget {
  MyKeyBoard({Key key, this.onClick, this.onDelete, this.onDeleteAll,this.onFinish, this.onMove})
      : super(key: key);
  VoidCallback onDeleteAll;
  VoidCallback onFinish;

  // ignore: top_level_function_literal_block
  var onClick = (String s) {};

  // ignore: top_level_function_literal_block
  var onDelete = (String s) {};

  var onMove = (bool isUp) {};

  @override
  KeyBoardState createState() => KeyBoardState();
}

class KeyBoardState extends State<MyKeyBoard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        width: double.infinity,
        height: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          color: Color.fromARGB(0xff, 0x2a, 0x31, 0x38),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                          text: "7",
                          onClick: widget.onClick,
                          iconPath: "images/icon-test_7.png")),
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                          text: "4",
                          onClick: widget.onClick,
                          iconPath: "images/icon-test_4.png")),
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                        text: "1",
                        onClick: widget.onClick,
                        iconPath: "images/icon-test_1.png",
                      )),
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                          text: ".",
                          onClick: widget.onClick,
                          iconPath: "images/point.png")),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                          text: "8",
                          onClick: widget.onClick,
                          iconPath: "images/icon-test_8.png")),
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                          text: "5",
                          onClick: widget.onClick,
                          iconPath: "images/icon-test_5.png")),
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                          text: "2",
                          onClick: widget.onClick,
                          iconPath: "images/icon-test_2.png")),
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                          text: "0",
                          onClick: widget.onClick,
                          iconPath: "images/icon-test_0.png")),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                          text: "9",
                          onClick: widget.onClick,
                          iconPath: "images/icon-test_9.png")),
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                          text: "6",
                          onClick: widget.onClick,
                          iconPath: "images/icon-test_6.png")),
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                          text: "3",
                          onClick: widget.onClick,
                          iconPath: "images/icon-test_3.png")),
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                          text: "<",
                          onClick: widget.onDelete,
                          longClick: () {
                            widget.onDeleteAll();
                          },
                          iconPath: "images/delete.png")),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                        text: "up",
                        onClick: (String s) => widget.onMove(true),
                        iconPath: "images/move_up.png",
                      )),
                  Expanded(
                      flex: 1,
                      child: KeyBoardButton(
                        text: "down",
                        onClick: (String s) => widget.onMove(false),
                        iconPath: "images/move_down.png",
                      )),
                  Expanded(
                      flex: 2,
                      child: KeyBoardButton(
                        text: "=",
                        onClick: (String s) => widget.onFinish(),
                        iconPath: "images/equal.png",
                        btnColor: Color.fromARGB(0xcc, 0x36, 0x3c, 0x4a),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KeyBoardButton extends StatelessWidget {
  KeyBoardButton(
      {Key key,
      this.text,
      this.onClick,
      this.longClick,
      this.iconPath,
      this.btnColor})
      : super(key: key);
  String text;

  // ignore: top_level_function_literal_block
  var onClick = (String s) {};
  VoidCallback longClick;
  String iconPath;
  Color btnColor;

  @override
  Widget build(BuildContext context) {
    Widget contentWidget;
    if (iconPath == null) {
      contentWidget = Text(
        text,
        style: TextStyle(
            color: Color.fromARGB(0xff, 0x88, 0x88, 0x88), fontSize: 20),
      );
    } else {
      contentWidget = Image.asset(
        iconPath,
        width: 26,
      );
    }
    return GestureDetector(
      onLongPress: longClick == null
          ? null
          : () {
              var _type = FeedbackType.light;
              Vibrate.feedback(_type);
              longClick();
            },
      child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          color: btnColor == null
              ? Color.fromARGB(0xff, 0x2a, 0x31, 0x38)
              : btnColor,
          elevation: 0,
          highlightElevation: 0,
          focusElevation: 0,
          highlightColor: Color.fromARGB(0x20, 0xff, 0xff, 0xff),
          child: contentWidget,
          onPressed: () {
            onClick(text);
          }),
    );
  }
}
