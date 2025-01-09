import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.title,
    required this.onPressed,
    required this.textColor,
    required this.filledColor
  });

  final String title;
  final Function? onPressed;
  final Color textColor;
  final Color filledColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed!();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 51.0,
              decoration: BoxDecoration(
                color: filledColor,
                border: Border.all(
                  color: filledColor,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w600,
                      color: textColor
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
