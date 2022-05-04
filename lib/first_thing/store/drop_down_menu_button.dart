import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

class DropDownMenuButton extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey1 = GlobalKey();
  final Function button_1;
  final Function button_2;
  final Function button_3;
  final Function button_4;
  final Function button_5;
  final Widget iconsOne;
  final Widget iconsTwo;
  final Widget iconsThree;
  final Widget iconsFour;
  final Widget iconsFive;

  final Color primaryColor;

  DropDownMenuButton(
      {this.button_1,
      this.iconsFive,
      this.iconsFour,
      this.iconsThree,
      this.iconsOne,
      this.iconsTwo,
      this.button_2,
      this.button_3,
      this.button_4,
      this.button_5,
      this.primaryColor});

  Widget build(BuildContext context) {
    return FabCircularMenu(
      key: fabKey1,
      // Cannot be `Alignment.center`
      alignment: Alignment.centerRight,
      ringColor: const Color.fromRGBO(3, 83, 151, 1).withOpacity(0.8),
      ringDiameter: 430.0,
      ringWidth: 150.0,
      fabSize: 50.0,
      fabElevation: 8.0,
      fabIconBorder: const CircleBorder(),
      // Also can use specific color based on weather
      // the menu is open or not:
      // fabOpenColor: Colors.white
      // fabCloseColor: Colors.white
      // These properties take precedence over fabColor
      fabColor: primaryColor,
      fabOpenIcon: const Icon(Icons.menu, color: Colors.white),
      fabCloseIcon: const Icon(Icons.close, color: Colors.white),
      fabMargin: const EdgeInsets.fromLTRB(16.0, 45, 16, 16),
      animationDuration: const Duration(milliseconds: 800),
      animationCurve: Curves.easeInOutCirc,
      onDisplayChange: (isOpen) {},
      children: <Widget>[
        Container(
          // padding: const EdgeInsets.fromLTRB(24.0, 100, 24, 24),
          child: RawMaterialButton(
            fillColor: Colors.green,
            onPressed: () {
              button_1();
              fabKey1.currentState.close();
            },
            shape: const CircleBorder(),
            child: iconsOne,
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            button_2();
            fabKey1.currentState.close();
          },
          shape: const CircleBorder(),
          //  padding: const EdgeInsets.fromLTRB(24.0, 50, 24, 24),
          //   padding: const EdgeInsets.only(top: 14.0, bottom: 14),
          child: iconsTwo,
        ),
        RawMaterialButton(
          onPressed: () {
            button_3();
            fabKey1.currentState.close();
          },
          shape: const CircleBorder(),
          //  padding: const EdgeInsets.only(top: 14.0, bottom: 14),
          child: iconsThree,
        ),
        RawMaterialButton(
          onPressed: () {
            button_4();
            fabKey1.currentState.close();
          },
          shape: const CircleBorder(),
          //  padding: const EdgeInsets.only(top: 14.0, bottom: 14),
          child: iconsFour,
        )
      ],
    );
  }
}
