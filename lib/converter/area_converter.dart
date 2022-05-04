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

  int selectedLengthFromList = 0;

  final formKeyLength = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final selectedLengthType =
        Provider.of<ConverterDataCalculation>(context).area;
    final data = Provider.of<ConverterDataCalculation>(context);

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
                    key: formKeyLength,
                    child: Container(
                      //  padding: const EdgeInsets.fromLTRB(18, 28, 18, 8),

                      child: TextFormField(
                        initialValue: '0',
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
                      value: selectedLengthFromList,
                      items: selectedLengthType
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(
                                e['mon'],
                                style: kkDropDown,
                              ),
                              value: e['day'],
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLengthFromList = value;
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
            itemCount: selectedLengthType.length,
            itemBuilder: (context, index) {
              String display = selectedLengthType[index]['mon'];

              return Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          selectedLengthFromList == 0
                              ? (data.mmA[index] * convertItem).toString()
                              : selectedLengthFromList == 1
                                  ? (data.cmA[index] * convertItem).toString()
                                  : selectedLengthFromList == 2
                                      ? (data.dmA[index] * convertItem)
                                          .toString()
                                      : selectedLengthFromList == 3
                                          ? (data.mA[index] * convertItem)
                                              .toString()
                                          : selectedLengthFromList == 4
                                              ? (data.inchA[index] *
                                                      convertItem)
                                                  .toString()
                                              : selectedLengthFromList == 5
                                                  ? (data.ftA[index] *
                                                          convertItem)
                                                      .toString()
                                                  : selectedLengthFromList == 6
                                                      ? (data.ydA[index] *
                                                              convertItem)
                                                          .toString()
                                                      : selectedLengthFromList ==
                                                              7
                                                          ? (data.haA[index] *
                                                                  convertItem)
                                                              .toString()
                                                          : selectedLengthFromList ==
                                                                  8
                                                              ? (data.mileA[
                                                                          index] *
                                                                      convertItem)
                                                                  .toString()
                                                              : selectedLengthFromList ==
                                                                      9
                                                                  ? (data.kmA[index] *
                                                                          convertItem)
                                                                      .toString()
                                                                  : selectedLengthFromList ==
                                                                          10
                                                                      ? (data.acreA[index] *
                                                                              convertItem)
                                                                          .toString()
                                                                      : '',
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
                color:
                    selectedLengthType[index]['day'] == selectedLengthFromList
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
