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
  const Textfieldcreate({
    super.key,
    required this.text1,
    required this.text2,
    required this.prefix,
    required this.suffix,
    required this.obscureText,
    this.onChanged,
    required this.validator,
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
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: prefix,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              suffix: suffix,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(
                  color: AppColors.vibrantBlue,
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
              fillColor: AppColors.grayPurple,
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}
