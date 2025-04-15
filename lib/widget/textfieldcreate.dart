import 'package:flutter/material.dart';
import 'package:flutter_backend_1/static/colors.dart';

// ignore: must_be_immutable
class Textfieldcreate extends StatelessWidget {
  final String text1;
  final String text2;
  final Widget prefix;
  final Widget suffix;
  final bool obscureText;
  final Function(String)? onChanged;
  final FormFieldValidator<String?> validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLength;

  const Textfieldcreate({
    super.key,
    required this.text1,
    required this.text2,
    required this.prefix,
    required this.suffix,
    required this.obscureText,
    this.onChanged,
    required this.validator,
    this.controller,
    required InputDecoration decoration,
    this.keyboardType,
    this.minLines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Text(
            text1,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            keyboardType: keyboardType ?? TextInputType.text,
            maxLength: maxLength, // Set max length here
            minLines: minLines, // Set min lines here
            maxLines:
                minLines == null
                    ? 1
                    : null, // Allow single line if minLines is null

            style: TextStyle(
              fontSize: 16.0, // Adjust based on your needs
              color: Colors.black, // Customize text color
            ),
            decoration: InputDecoration(
              prefixIcon: prefix,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              suffix: suffix,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(
                  color: const Color.fromRGBO(79, 70, 229, 1),
                  width: 3.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(
                  color: AppColors.vibrantBlue,
                  width: 3.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: AppColors.vibrantBlue, width: 3),
              ),
              hintText: text2,
              hintStyle: TextStyle(
                color: Colors.black45,
              ), // Styling the hint text
              fillColor: Color(0xFFF7ECE1),
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}
