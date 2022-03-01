import 'dart:math';
import 'package:example/shop_list/shop_form.dart';
import 'package:example/shop_list/shop_model.dart';
import 'package:example/shop_list/shop_update_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'database_helper/shop_database_helper.dart';
import 'files.dart';

class ShopList extends StatefulWidget {
  static const routeName = '/ShopList';

  const ShopList({Key key}) : super(key: key);

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  int red = 0;
  int green = 0;
  int blue = 0;
  int id = 0;

  @override
  void initState() {
    var rng = Random();
    red = rng.nextInt(251);
    green = rng.nextInt(251);
    blue = rng.nextInt(251);
    print('red: $red green: $green blue: $blue');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Provider.of<ShopHandler>(context, listen: false).createTable();
              });
            },
            icon: const Icon(Icons.save),
          ),
        ],
        backgroundColor: Color.fromRGBO(red, green, blue, 1),
        title: const Text('Shop List'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Shop>>(
        stream: DatabaseHelper.getInstance().getAllItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          final items = snapshot.data;
          final newLabour = snapshot.data
              .map((e) => ShopModel(
                    price: e.price,
                    name: e.name,
                    quantity: e.quantity,
                    date:  e.date,

                  ))
              .toList();
          Provider.of<ShopHandler>(context, listen: false).fileList = newLabour;
          return Container(
            height: double.infinity,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => Dismissible(
                key: ObjectKey(items),
                background: slideRightBackground(),
                secondaryBackground: slideLeftBackground(),
                confirmDismiss: (direction) {
                  return direction == DismissDirection.endToStart
                      ? showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Are you sure'),
                            actions: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                                child: const Text('No'),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(true);
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                            content: const Text(
                                'Do you want to remove this item from the cart?'),
                          ),
                        )
                      : showModalBottomSheet(
                          context: context,
                          builder: (ctx) => ShopUpdateForm(
                            index: items[index].id,
                            name: items[index].name,
                            date: items[index].date,
                            price: items[index].price,
                            quantity: items[index].quantity,
                            total: items[index].total,
                          ),
                        );
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(red, green, blue, 1).withOpacity(0.7),
                        const Color.fromRGBO(76, 175, 80, 1),
                      ],
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 0),
                    // trailing: Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //    IconButton(onPressed: (){}, icon: Icon(Icons.edit,),),
                    //     IconButton(onPressed: (){}, icon: Icon(Icons.delete_forever,),),
                    //   ],
                    // ),
                    title: Text(
                      items[index].name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                         items[index].date,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Tot Price: ${items[index].total} ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: Text(
                            'ETB\n ${items[index].price}',
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '${items[index].quantity} x ',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(red, green, blue, 1).withOpacity(0.7),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (ctx) => ShopForm(),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Icon(
        Icons.edit,
        size: 40,
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.green),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete_forever,
        size: 40,
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.red),
    );
  }
}
