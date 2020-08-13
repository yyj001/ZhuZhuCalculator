import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  EditText({Key key, this.list, this.hint}) : super(key: key);

  final List<DropdownMenuItem<double>> list;
  String hint;

  @override
  EditTextState createState() => EditTextState();
}

class EditTextState extends State<EditText> {
  EditTextState({List<DropdownMenuItem<double>> list});

  double unit = 1.0;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Row row = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200,
          height: 70,
          child: TextField(
//              focusNode: _focusNodes[0],
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(),
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
//                  fillColor: _colors[0],
                  labelText: widget.hint,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)))),
        ),
      ],
    );
    if (widget.list != null) {
      row.children.add(DropdownButton(
        value: unit,
        items: widget.list,
        underline: Container(height: 0),
        onChanged: (value) {
          setState(() {
            unit = value;
          });
        },
      ));
    }
    return row;
  }
}
