import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';

class TextInputField extends StatefulWidget {
  final String labelText;
  final double height;
  final int maxLines;
  final int maxLength;
  final bool onlyNumbers;

  TextInputField({
    required this.labelText,
    required this.height,
    this.maxLines = 1,
    this.maxLength = TextField.noMaxLength,
    this.onlyNumbers = false,
  });

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.height,
          child: TextField(
            controller: _controller,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            inputFormatters: widget.onlyNumbers
                ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                : null,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: AppColors.lightGray),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: AppColors.lightGray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: AppColors.lightGray),
              ),
              labelText: widget.labelText,
              labelStyle: AppFonts.interMedium(
                  color: AppColors.lightGray, fontsize: 14),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              counterText: '',
              alignLabelWithHint: true,
            ),
            style: TextStyle(fontSize: 12),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${_controller.text.length}/${widget.maxLength}',
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
