import 'package:flutter/material.dart';
import 'package:task_management_app_flutter/auth/screens/login_screen.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/constants/assets_constants.dart';
import 'package:task_management_app_flutter/constants/custom_button.dart';
import 'package:task_management_app_flutter/constants/global_variables.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.boneWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset(AssetsConstants.welcome_screen_human, width: 250, height: 250)),
                const SizedBox(height: 150),
                const Text("Task Management &\nTo-Do List",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                const Text("This productive tool is designed to help you better manage your task project-wise conveniently!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 30),
                CustomButton(
                    width: double.infinity,
                    onClick: (){
                      Navigator.pushNamed(context, LoginSceen.routeName);
                    },
                    buttonText: "Let's Start",
                    borderRadius: 20,
                    buttonColor: Colors.indigo,
                    textColor: MyColors.boneWhite,
                    fontWeight: FontWeight.bold,
                    buttonTextSize: 17,
                    showSuffixIcon: true,
        
                ),
              ],
          ),
        ),
      ),

    );
  }
}

class BentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const BentButton({Key? key, required this.onPressed, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CustomPaint(
        painter: BentButtonPainter(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: child,
        ),
      ),
    );
  }
}

class BentButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.2, 0, size.width * 0.35, 0)
      ..lineTo(size.width * 0.65, 0)
      ..quadraticBezierTo(size.width * 0.8, 0, size.width, size.height * 0.2)
      ..lineTo(size.width, size.height * 0.8)
      ..quadraticBezierTo(size.width * 0.8, size.height, size.width * 0.65, size.height)
      ..lineTo(size.width * 0.35, size.height)
      ..quadraticBezierTo(size.width * 0.2, size.height, 0, size.height * 0.8)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
