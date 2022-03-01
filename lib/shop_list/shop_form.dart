import 'package:example/shop_list/files.dart';
import 'package:example/shop_list/shop_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'database_helper/shop_database_helper.dart';

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
  DateTime date = DateTime.now();

  void showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().month - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    ).then((val) {
      setState(() {
        date = val;
      });
    });
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
                DateFormat.yMMMEd().format(date),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  int x = Provider.of<ShopHandler>(context,listen: false)
                      .totalPrice(double.parse(quantity), double.parse(price));
                  await DatabaseHelper.getInstance().insert(
                    Shop(
                      name: name,
                      date: date.toString(),
                      quantity: quantity,
                      price: price,
                      total: x,
                    ),
                  );
                  print(x);
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
