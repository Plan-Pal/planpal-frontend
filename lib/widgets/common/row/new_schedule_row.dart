import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';

class SectionSelector extends StatefulWidget {
  final ValueChanged<int> onSectionSelected;

  const SectionSelector({Key? key, required this.onSectionSelected})
      : super(key: key);

  @override
  _SectionSelectorState createState() => _SectionSelectorState();
}

class _SectionSelectorState extends State<SectionSelector> {
  int _selectedSection = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedSection = 0;
            });
            widget.onSectionSelected(_selectedSection);
          },
          child: Container(
            padding: EdgeInsets.only(bottom: 4.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: _selectedSection == 0
                      ? AppColors.darkGray
                      : Colors.transparent,
                  width: 1.0,
                ),
              ),
            ),
            child: Text('진행 전 약속',
                style: AppFonts.interRegular(
                    color: AppColors.darkGray, fontsize: 17)),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedSection = 1;
            });
            widget.onSectionSelected(_selectedSection);
          },
          child: Container(
            padding: EdgeInsets.only(bottom: 4.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: _selectedSection == 1
                      ? AppColors.darkGray
                      : Colors.transparent,
                  width: 1.0,
                ),
              ),
            ),
            child: Text('정산 중 약속',
                style: AppFonts.interRegular(
                    color: AppColors.darkGray, fontsize: 17)),
          ),
        ),
      ],
    );
  }
}
