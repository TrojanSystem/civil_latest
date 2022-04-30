import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

class DropDownMenuButtonForDailyTodos extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKeyForDailyTodos = GlobalKey();
  final Function button_11;
  final Function button_22;
  final Function button_33;
  final Function button_44;
  final Color primaryColor;
  final Widget iconsOne;
  final Widget iconsTwo;
  final Widget iconsThree;
  final Widget iconsFour;

  DropDownMenuButtonForDailyTodos(
      {this.button_11,
      this.iconsOne,
      this.iconsTwo,
      this.iconsThree,
      this.iconsFour,
      this.button_22,
      this.button_33,
      this.button_44,
      this.primaryColor});

  Widget build(BuildContext context) {
    return FabCircularMenu(
      key: fabKeyForDailyTodos,
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
        RawMaterialButton(
          fillColor: Colors.green,
          onPressed: () {
            button_11();
            fabKeyForDailyTodos.currentState.close();
          },
          shape: const CircleBorder(),
          //padding: const EdgeInsets.fromLTRB(24.0, 100, 24, 24),
          child: iconsOne,
        ),
        RawMaterialButton(
          onPressed: () {
            button_22();
            fabKeyForDailyTodos.currentState.close();
          },
          shape: const CircleBorder(),
          //  padding: const EdgeInsets.fromLTRB(24.0, 50, 24, 24),
          padding: const EdgeInsets.all(24.0),
          child: iconsTwo,
        ),
        RawMaterialButton(
          onPressed: () {
            button_33();
            fabKeyForDailyTodos.currentState.close();
          },
          shape: const CircleBorder(),
          //padding: const EdgeInsets.all(24.0),
          child: iconsThree,
        ),
        RawMaterialButton(
          onPressed: () {
            button_44();
            fabKeyForDailyTodos.currentState.close();
          },
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: iconsFour,
        )
      ],
    );
  }
}
