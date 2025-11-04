import 'package:flutter/material.dart';

class TextFieldCommon extends StatelessWidget {
  var hint, errorText;
  TextEditingController? controller;
  Icon? icon;
  TextInputType? keyboardType;
  bool? isSecure;

  TextFieldCommon(
      {required this.controller, required this.hint, this.errorText, this.icon,this.keyboardType,this.isSecure});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            controller: controller,
            obscureText: isSecure??false,
            keyboardType: keyboardType ?? TextInputType.text,
            textAlign: TextAlign.left,
            maxLength: 11,

            decoration: InputDecoration(
              // icon: Icon(Icons.send), //  outside box icon....................................
              prefixIcon: icon,
              hintText: hint,
              helperText: null,
              errorText: errorText,
            //  counter: Container(),

              counterText: '',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
