import 'package:flutter/material.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/constants/my_fonts.dart';

class DayWidget extends StatefulWidget {
  final String day;
  final bool isToday;
  final int date;
  const DayWidget({super.key, required this.day, required this.isToday, required this.date});

  @override
  State<DayWidget> createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
            Text(widget.date.toString(),
              style: TextStyle(
                fontFamily: MyFonts.poppins,
                fontSize: 13,
                color: MyColors.fadedBlack
              ),
            ),
            Text(widget.day,
              style: TextStyle(
                  fontFamily: MyFonts.poppins,
                  fontSize: 13,
                  color: MyColors.fadedBlack
              ),
            )
        ],
      ),
    );
  }
}
