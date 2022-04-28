import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'converter_data_calculation.dart';

class AreaConverter extends StatefulWidget {
  AreaConverter({Key key}) : super(key: key);

  @override
  State<AreaConverter> createState() => _AreaConverterState();
}

class _AreaConverterState extends State<AreaConverter> {
  double convertItem = 0.0;

  int selectedAreaFromList = 0;

  final formKeyArea = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final selectedAreaType =
        Provider.of<ConverterDataCalculation>(context).area;

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Form(
                    key: formKeyArea,
                    child: Container(
                      //  padding: const EdgeInsets.fromLTRB(18, 28, 18, 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Value can\'t be empty';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            convertItem = double.parse(value);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Value',
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            //   borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            // borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: DropdownButton(
                      dropdownColor: Colors.grey[850],
                      iconEnabledColor: Colors.white,
                      menuMaxHeight: 800,
                      value: selectedAreaFromList,
                      items: selectedAreaType
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(
                                e['mon'],
                                style: kkDropDown,
                              ),
                              value: e['day'] - 1,
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedAreaFromList = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: ListView.builder(
            itemCount: selectedAreaType.length,
            itemBuilder: (context, index) {
              String display = selectedAreaType[index]['mon'];
              return Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          convertItem.toString(),
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          display.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                width: double.infinity,
                height: 50,
                color: selectedAreaType[index]['day'] == selectedAreaFromList
                    ? Colors.blue[300]
                    : const Color.fromRGBO(3, 83, 151, 1),
              );
            },
          ),
        ),
      ],
    );
  }
}
