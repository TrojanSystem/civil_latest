import 'package:example/shop_list/shop_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'database_helper/shop_database_helper.dart';
import 'files.dart';

class ShopUpdateForm extends StatefulWidget {
  int index = 0;
  int total = 0;
  String name = '';
  String quantity = '';
  String price = '';
  String date = '';

  ShopUpdateForm(
      {this.total,
      this.index,
      this.price,
      this.quantity,
      this.name,
      this.date});

  @override
  State<ShopUpdateForm> createState() => _ShopUpdateFormState();
}

class _ShopUpdateFormState extends State<ShopUpdateForm> {
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
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.name,
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
                initialValue: widget.quantity,
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
                initialValue: widget.price,
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
                  DateFormat.yMMMEd().format(
                    date,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    int total = Provider.of<ShopHandler>(context, listen: false)
                        .totalPrice(
                            double.parse(quantity), double.parse(price));
                    bool x = await DatabaseHelper.getInstance().update(
                      Shop(
                        id: widget.index,
                        name: name,
                        date: DateFormat.yMMMEd().format(date),
                        quantity: quantity,
                        price: price,
                        total: total,
                      ),
                    );
                    print(x);
                    Navigator.pop(context);
                  }
                  setState(() {});
                },
                child: const Text('Update Item'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
