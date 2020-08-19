import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  EditText(
      {Key key, this.list, this.hint, this.onTap, this.isSelected, this.icon, this.enable})
      : super(key: key);

  final List<DropdownMenuItem<double>> list;
  String hint;
  VoidCallback onTap;
  bool isSelected;
  String icon;
  bool enable = true;

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
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Image.asset(
            widget.icon,
            width: 25,
            height: 25,
          ),
        ),
      ],
    );
    /**
     * textfield
     */
    row.children.add(Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: TextField(
              enabled: widget.enable,
              focusNode: _focusNodes,
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(),
              style: TextStyle(fontSize: 28),
              decoration: InputDecoration(
                labelText: widget.hint,
                border: InputBorder.none,
                labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
              )),
        ),
      ),
    ));

    /**
     * 单位
     */
    if (widget.list != null) {
      row.children.add(Container(
        padding: EdgeInsets.fromLTRB(0, 0, 17, 0),
        child: DropdownButton(
          value: unit,
          items: widget.list,
          icon: Image.asset(
            "images/down.png",
            width: 20,
            height: 20,
          ),
          underline: Container(height: 0),
          onChanged: (value) {
            setState(() {
              unit = value;
              if(widget.enable){
                FocusScope.of(context).requestFocus(_focusNodes);
              }
            });
          },
        ),
      ));
    }
    if (widget.isSelected) {
      _focusNodes.requestFocus();
    }
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 50, minWidth: double.infinity),
      child: Container(
        color: widget.isSelected == true
            ? Color.fromARGB(0x09, 0x33, 0x33, 0x33)
            : Colors.white,
        child: row,
      ),
    );
  }
}
