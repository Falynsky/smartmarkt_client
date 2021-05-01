import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/utilities/constant_styles.dart';

class TextFieldComponent extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String placeHolder;
  final IconData icon;
  final bool isRequired;
  final bool? obscureText;
  final bool? isMail;
  final bool? autoValidate;

  TextFieldComponent({
    required this.controller,
    required this.label,
    required this.placeHolder,
    required this.icon,
    required this.isRequired,
    this.obscureText,
    this.isMail,
    this.autoValidate,
  });

  @override
  _TextFieldComponentState createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  late TextEditingController _controller;
  late String _label;
  late String _placeHolder;
  late IconData _icon;
  late bool _isRequired;
  late bool _obscureText;
  late bool _isMail;
  late bool? _autoValidate;

  bool get _isAutoValidate => _autoValidate != null && _autoValidate == false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _label = widget.label;
    _placeHolder = widget.placeHolder;
    _icon = widget.icon;
    _isRequired = widget.isRequired;
    _obscureText = widget.obscureText ?? false;
    _isMail = widget.isMail ?? false;
    _autoValidate = widget.autoValidate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(_label, style: labelStyle),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              obscureText: _obscureText,
              autovalidateMode: _isAutoValidate ? null : AutovalidateMode.onUserInteraction,
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

  String? _validateField(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty && _isRequired) {
      return 'Proszę wprowadzić wartość.';
    }

    RegExp regExp = new RegExp(r'(\s)');
    if (regExp.hasMatch(value)) {
      return 'Puste znaki niedozwolone.';
    }
    RegExp regExpMail = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (_isMail && !regExpMail.hasMatch(value)) {
      return 'Błędy format maila.';
    }

    return null;
  }

  InputDecoration _textFieldInputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: complementaryOne,
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
