import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyKeyBoard extends StatefulWidget {
  @override
  KeyBoardState createState() => KeyBoardState();
}

class KeyBoardState extends State<MyKeyBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      color: Color.fromARGB(0xff, 0x2a, 0x31, 0x38),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
                Expanded(flex: 1, child: KeyBoardButton(text: "1")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class KeyBoardButton extends StatelessWidget {
  KeyBoardButton({Key key, this.text}) : super(key: key);
  String text;

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
          onPressed: () {}),
    );
  }
}
