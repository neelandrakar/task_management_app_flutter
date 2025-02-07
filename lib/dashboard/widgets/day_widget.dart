import 'package:flutter/material.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/constants/my_fonts.dart';

class DayWidget extends StatefulWidget {
  final String day;
  final bool isToday;
  final int date;
  final bool? hasDone;
  const DayWidget({super.key, required this.day, required this.isToday, required this.date, this.hasDone});

  @override
  State<DayWidget> createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {


  @override
  Widget build(BuildContext context) {

    Color textColor = widget.isToday ? MyColors.boneWhite : MyColors.greyColor;
    Color borderColor = widget.isToday ? MyColors.boneWhite : MyColors.darkBlack;

    getDataTickWidget(){
      print('xx ${widget.hasDone}');
      if(widget.hasDone==null){
        return Text(widget.date.toString(),
          maxLines: 1,
          style: TextStyle(
              fontFamily: MyFonts.poppins,
              fontSize: 13,
              color: textColor
          ),
        );
      } else {
        if(widget.hasDone!) {
          return Icon(Icons.check_box_rounded, color: MyColors.redCheckBoxColor,);
        } else {
          if(!widget.isToday) {
            return Icon(Icons.check_box_outline_blank_outlined,
              color: MyColors.greyColor,);
          } else {
            return Icon(Icons.square_rounded,
              color: MyColors.greyColor,);          }
        }
      }
    }

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 0.5),
        borderRadius: BorderRadius.circular(20)
        // color: Colors.red
      ),
      height: double.infinity,
      width:10,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Text(widget.day,
              maxLines: 1,
              style: TextStyle(
                fontFamily: MyFonts.poppins,
                fontSize: 13,
                color: textColor,
              ),
            ),
          SizedBox(height: 2),
          getDataTickWidget()
        ],
      ),
    );
  }
}
