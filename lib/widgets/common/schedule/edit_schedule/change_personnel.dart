import 'package:flutter/material.dart';
import 'package:planpal_frontend/themes/colors.dart';
import 'package:planpal_frontend/themes/fonts.dart';
import 'package:planpal_frontend/themes/icons.dart';

class LimitlessOption extends StatefulWidget {
  @override
  _LimitlessOptionState createState() => _LimitlessOptionState();
}

class _LimitlessOptionState extends State<LimitlessOption> {
  bool _noLimit = false;
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('약속 인원',
                style: AppFonts.interRegular(
                    color: AppColors.darkGray, fontsize: 15)),
            TextButton(
              onPressed: () {
                setState(() {
                  _noLimit = !_noLimit;
                  if (_noLimit) {
                    _count = 0;
                  }
                });
              },
              child: Row(
                children: [
                  AppIcon().getCheckIcon(
                      color:
                          _noLimit ? AppColors.darkGray : AppColors.lightGray,
                      height: 8,
                      width: 8),
                  const SizedBox(width: 3),
                  Text(
                    '제한없음',
                    style: AppFonts.interMedium(
                        color:
                            _noLimit ? AppColors.darkGray : AppColors.lightGray,
                        fontsize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGray), // 경계선 추가
            borderRadius: BorderRadius.circular(5), // 경계선의 모서리를 둥글게
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                      right:
                          BorderSide(color: AppColors.lightGray)), // 오른쪽 경계선 추가
                ),
                child: IconButton(
                  icon: Icon(Icons.remove,
                      color: _count > 0 && !_noLimit
                          ? AppColors.darkGray
                          : AppColors.lightGray), // 상태에 따라 색상 변경
                  onPressed: _count > 0 && !_noLimit
                      ? () {
                          setState(() {
                            _count--;
                          });
                        }
                      : null, // 카운트가 0이거나 제한 없음이 선택되었을 때 버튼 비활성화
                ),
              ),
              Container(
                child: Text('$_count명',
                    style: TextStyle(
                        color: _noLimit
                            ? AppColors.lightGray
                            : AppColors.darkGray)), // 상태에 따라 색상 변경
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                      left:
                          BorderSide(color: AppColors.lightGray)), // 왼쪽 경계선 추가
                ),
                child: IconButton(
                  icon: Icon(Icons.add,
                      color: _noLimit
                          ? AppColors.lightGray
                          : AppColors.darkGray), // 상태에 따라 색상 변경
                  onPressed: !_noLimit
                      ? () {
                          setState(() {
                            _count++;
                          });
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
