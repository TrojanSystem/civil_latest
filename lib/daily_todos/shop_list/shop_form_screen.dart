import 'package:example/daily_todos/shop_list/shop_input_form.dart';
import 'package:flutter/material.dart';

class ShopFormScreen extends StatelessWidget {
  const ShopFormScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter The Item'),
      ),
      body: ShopForm(),
    );
  }
}
