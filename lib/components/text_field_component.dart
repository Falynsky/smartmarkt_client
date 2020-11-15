import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/constants.dart';

class TextFieldComponent extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String placeHolder;
  final IconData icon;
  final bool isRequired;

  TextFieldComponent({
    @required this.controller,
    @required this.label,
    @required this.placeHolder,
    @required this.icon,
    @required this.isRequired,
  });

  @override
  _TextFieldComponentState createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  TextEditingController _controller;
  String _label;
  String _placeHolder;
  IconData _icon;
  bool _isRequired;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _label = widget.label;
    _placeHolder = widget.placeHolder;
    _icon = widget.icon;
    _isRequired = widget.isRequired ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _label,
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextFormField(
              validator: (String value) {
                if (value.isEmpty && _isRequired) {
                  return 'To pole jest wymagane';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              controller: _controller,
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  _icon,
                  color: Colors.white,
                ),
                hintText: _placeHolder,
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
