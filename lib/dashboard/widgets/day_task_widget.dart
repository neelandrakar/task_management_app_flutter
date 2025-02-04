import 'package:flutter/material.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/dashboard/screens/add_streak_screen.dart';

import '../../constants/my_fonts.dart';

class DayTaskWidget extends StatefulWidget {
  final int task_id;
  final String task_type_name;
  final String task_icon;
  final int target;
  final int total_done;
  final String task_color;
  final String task_unit;
  final int streak;
  const DayTaskWidget({
    super.key,
    required this.task_id,
    required this.task_type_name,
    required this.task_icon,
    required this.target,
    required this.total_done,
    required this.task_color,
    required this.task_unit,
    required this.streak
  });

  @override
  State<DayTaskWidget> createState() => _DayTaskWidgetState();
}

class _DayTaskWidgetState extends State<DayTaskWidget> {

  void navigateToAddStreak(int task_id, String task_type_name){

    final arguments = AddStreakScreen(task_id: task_id, task_type_name: task_type_name,);

    Navigator.pushNamed(context, AddStreakScreen.routeName, arguments: arguments);
  }


  @override
  Widget build(BuildContext context) {

    Color streakBoxColor = widget.streak>0 ? MyColors.boneWhite.withOpacity(0.3) : MyColors.darkBlue;
    Color streakBoxTextColor = widget.streak>0 ? MyColors.boneWhite : MyColors.darkBlue;
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: MyColors.darkBlue,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(int.parse("0xFF${widget.task_color}"))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(widget.task_icon, width: 30, height: 30),
          SizedBox(height: 2),
          Text(
            widget.task_type_name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              color: MyColors.boneWhite, // Base text color
              fontSize: 16,
              fontFamily: MyFonts.kumbhSans,
              fontWeight: FontWeight.w400, // Slightly bolder for a modern feel
            ),
          ),
          SizedBox(height: 5),
          if(widget.streak>=0)
            Container(
              width: 50,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: streakBoxColor
              ),
              padding: EdgeInsets.all(5),
              child: Text(
                "${widget.streak} days",
                style: TextStyle(
                  color: streakBoxTextColor,
                  fontFamily: MyFonts.kumbhSans,
                  fontWeight: FontWeight.w300,
                  fontSize: 10
                ),
              ),
            ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${widget.total_done}/${widget.target} ",
                      style: TextStyle(
                        color: MyColors.boneWhite,
                        fontFamily: MyFonts.kumbhSans,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: widget.task_unit,
                      style: TextStyle(
                        color: MyColors.boneWhite,
                        fontFamily: MyFonts.kumbhSans,
                        fontWeight: FontWeight.w300, // Not bold
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, color: MyColors.boneWhite, size: 20 ),
                onPressed: () {
                  // Add your onPressed logic here

                  navigateToAddStreak(7, widget.task_type_name);
                },
              ),
            ],
          )

        ],
      ),
    );
  }
}
