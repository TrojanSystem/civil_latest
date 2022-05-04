import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'converter_data_calculation.dart';

class WeightConverter extends StatefulWidget {
  WeightConverter({Key key}) : super(key: key);

  @override
  State<WeightConverter> createState() => _WeightConverterState();
}

class _WeightConverterState extends State<WeightConverter> {
  double convertItem = 0.0;

  int selectedLengthFromList = 0;

  final formKeyLength = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final selectedLengthType =
        Provider.of<ConverterDataCalculation>(context).weight;
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
                              ? (data.umW[index] * convertItem).toString()
                              : selectedLengthFromList == 1
                                  ? (data.mmW[index] * convertItem).toString()
                                  : selectedLengthFromList == 2
                                      ? (data.gW[index] * convertItem)
                                          .toString()
                                      : selectedLengthFromList == 3
                                          ? (data.kgW[index] * convertItem)
                                              .toString()
                                          : selectedLengthFromList == 4
                                              ? (data.ibW[index] * convertItem)
                                                  .toString()
                                              : selectedLengthFromList == 5
                                                  ? (data.ozW[index] *
                                                          convertItem)
                                                      .toString()
                                                  : selectedLengthFromList == 6
                                                      ? (data.tonne[index] *
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
