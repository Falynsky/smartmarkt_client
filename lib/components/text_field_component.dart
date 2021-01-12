import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/constant_styles.dart';

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
          Text(_label, style: labelStyle),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _validateField,
              textInputAction: TextInputAction.next,
              controller: _controller,
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: _textFieldInputDecoration(),
            ),
          ),
        ],
      ),
    );
  }

  String _validateField(String value) {
    if (value.isEmpty && _isRequired) {
      return 'Proszę wprowadzić wartość.';
    }

    RegExp regExp = new RegExp(r'(\s)');
    if (regExp.hasMatch(value)) {
      return 'Puste znaki niedozwolone.';
    }

    return null;
  }

  InputDecoration _textFieldInputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Color(0xFF309c93),
      focusedBorder: focusedBorderStyle,
      enabledBorder: enabledBorderStyle,
      contentPadding: EdgeInsets.only(top: 14.0),
      prefixIcon: Icon(_icon, color: Colors.white),
      hintText: _placeHolder,
      hintStyle: hintTextStyle,
      errorStyle: errorMessageStyle,
      errorBorder: inputErrorBorderStyle,
    );
  }
}
