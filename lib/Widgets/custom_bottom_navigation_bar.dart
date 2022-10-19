import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Constants/colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({
    this.selectedIndex,
    this.onBottomIconPressed,
    Key? key,
  }) : super(key: key);

  int? selectedIndex;

  Function? onBottomIconPressed;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => widget.onBottomIconPressed!(0),
            icon: Icon(
              Icons.location_on,
              color: widget.selectedIndex! == 0
                  ? AppColors.kSecondaryColor
                  : Colors.grey.shade500,
            ),
          ),
          MaterialButton(
            onPressed: () => widget.onBottomIconPressed!(1),
            shape: CircleBorder(
              side: BorderSide(
                color: widget.selectedIndex! == 1
                    ? AppColors.kSecondaryColor
                    : Colors.grey,
                width: 8,
              ),
            ),
          ),
          IconButton(
            onPressed: () => widget.onBottomIconPressed!(2),
            icon: Icon(
              Icons.settings,
              color: widget.selectedIndex! == 2
                  ? AppColors.kSecondaryColor
                  : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
