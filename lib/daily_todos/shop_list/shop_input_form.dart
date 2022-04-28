import 'package:example/daily_todos/shop_list/files.dart';
import 'package:example/daily_todos/shop_list/shop_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'daily_shop_data.dart';

class ShopForm extends StatefulWidget {
  const ShopForm({Key key}) : super(key: key);

  @override
  State<ShopForm> createState() => _ShopFormState();
}

class _ShopFormState extends State<ShopForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String quantity = '';
  String price = '';
  String date = DateTime.now().toString();

  void showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      firstDate: DateTime(DateTime.now().month + 1),
    ).then((value) => setState(() {
          if (value != null) {
            date = value.toString();
          } else {
            date = DateTime.now().toString();
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter Valid Name';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                label: const Text('Name'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSaved: (value) {
                name = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                final pattern = RegExp("^[0-9]{1,10}");
                if (value.isEmpty) {
                  return 'Enter the quantity';
                } else if (!pattern.hasMatch(value)) {
                  return 'Enter Valid quantity';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                label: const Text('Quantity'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSaved: (value) {
                quantity = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                final pattern = RegExp("^[0-9]{1,10}");
                if (value.isEmpty) {
                  return 'Enter the price';
                } else if (!pattern.hasMatch(value)) {
                  return 'Enter Valid valid price';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                label: const Text('Unit Price'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSaved: (value) {
                price = value;
              },
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: showDate,
                icon: const Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.blue,
                ),
              ),
              Text(
                DateFormat.yMMMEd().format(DateTime.parse(date)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  int x = Provider.of<ShopHandler>(context, listen: false)
                      .totalPrice(double.parse(quantity), double.parse(price));

                  Provider.of<DailyShopData>(context, listen: false)
                      .addDailyShopList(
                    Shop(
                      name: name,
                      date: date,
                      quantity: quantity,
                      price: price,
                      total: x,
                    ),
                  );

                  Navigator.pop(context);
                }
                setState(() {});
              },
              child: const Text('Save Item'),
            ),
          )
        ],
      ),
    );
  }
}
