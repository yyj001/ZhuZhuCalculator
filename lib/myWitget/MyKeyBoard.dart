import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyKeyBoard extends StatefulWidget {
  MyKeyBoard({Key key, this.onClick, this.onDelete, this.onDeleteAll}) : super(key: key);
  VoidCallback onDeleteAll;
  // ignore: top_level_function_literal_block
  var onClick = (String s){};
  // ignore: top_level_function_literal_block
  var onDelete = (String s){};

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
        width: double.infinity,
        height: 320,
        color: Color.fromARGB(0xff, 0x2a, 0x31, 0x38),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(flex: 1, child: KeyBoardButton(text: "1", onClick: widget.onClick,)),
                  Expanded(flex: 1, child: KeyBoardButton(text: "4", onClick: widget.onClick,)),
                  Expanded(flex: 1, child: KeyBoardButton(text: "7", onClick: widget.onClick,)),
                  Expanded(flex: 1, child: KeyBoardButton(text: ".", onClick: widget.onClick,)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(flex: 1, child: KeyBoardButton(text: "2", onClick: widget.onClick,)),
                  Expanded(flex: 1, child: KeyBoardButton(text: "5", onClick: widget.onClick,)),
                  Expanded(flex: 1, child: KeyBoardButton(text: "8", onClick: widget.onClick,)),
                  Expanded(flex: 1, child: KeyBoardButton(text: "0", onClick: widget.onClick,)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(flex: 1, child: KeyBoardButton(text: "3", onClick: widget.onClick,)),
                  Expanded(flex: 1, child: KeyBoardButton(text: "6", onClick: widget.onClick,)),
                  Expanded(flex: 1, child: KeyBoardButton(text: "9", onClick: widget.onClick,)),
                  Expanded(flex: 1, child: KeyBoardButton(text: "<", onClick: widget.onDelete,)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(flex: 1, child: KeyBoardButton(text: "1", onClick: widget.onClick,)),
                  Expanded(flex: 1, child: KeyBoardButton(text: "4", onClick: widget.onClick,)),
                  Expanded(flex: 1, child: KeyBoardButton(text: "7", onClick: widget.onClick,)),
                  Expanded(flex: 1, child: KeyBoardButton(text: ".", onClick: widget.onClick,)),
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
  KeyBoardButton({Key key, this.text, this.onClick}) : super(key: key);
  String text;
  // ignore: top_level_function_literal_block
  var onClick = (String s){};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: RaisedButton(
          color: Color.fromARGB(0xff, 0x2a, 0x31, 0x38),
          elevation: 0,
          highlightElevation: 0,
          focusElevation: 0,
          highlightColor: Colors.transparent,
          child: Text(
            text,
            style: TextStyle(color: Colors.blueGrey, fontSize: 20),
          ),
          onPressed: () {
            onClick(text);
          }),
    );
  }
}
