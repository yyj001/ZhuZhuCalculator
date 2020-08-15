import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  EditText({Key key, this.list, this.hint, this.onTap, this.isSelected})
      : super(key: key);

  final List<DropdownMenuItem<double>> list;
  String hint;
  VoidCallback onTap;
  bool isSelected;

  @override
  EditTextState createState() => EditTextState();
}

class EditTextState extends State<EditText> {
  EditTextState({List<DropdownMenuItem<double>> list});

  FocusNode _focusNodes = FocusNode();
  double unit = 1.0;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNodes.addListener(() {
      if (_focusNodes.hasFocus) {
        print(widget.hint);
        widget.onTap();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Row row = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: TextField(
              focusNode: _focusNodes,
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(),
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
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
            FocusScope.of(context).requestFocus(_focusNodes);
          });
        },
      ));
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 50,
        minWidth: double.infinity
      ),
      child:Container(
        color: widget.isSelected == true? Color.fromARGB(0x05, 0x33, 0x33, 0x33): Colors.white,
        child: row,
      ),
    );
  }
}
