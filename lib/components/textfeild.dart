import 'package:flutter/material.dart';

class CustomReusbleTextFeild extends StatefulWidget {
  const CustomReusbleTextFeild(
      {super.key,
      required this.title,
      required this.hintText,
      this.isNumber,
      this.controller,
      required this.formKey});
  final String title, hintText;
  final bool? isNumber;
  final TextEditingController? controller;
  final Key formKey;

  @override
  State<CustomReusbleTextFeild> createState() => _CustomReusbleTextFeildState();
}

class _CustomReusbleTextFeildState extends State<CustomReusbleTextFeild> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: widget.formKey,
        controller: widget.controller,
        keyboardType:
            widget.isNumber == true ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: widget.title,
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }
}
