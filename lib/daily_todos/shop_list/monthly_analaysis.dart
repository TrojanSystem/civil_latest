import 'package:example/daily_todos/shop_list/files.dart';
import 'package:example/daily_todos/shop_list/update_shop_input_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../first_thing/store/add_to_store/shop_model_data_for_store.dart';
import 'daily_shop_data.dart';

class MonthlyAnalaysis extends StatefulWidget {
  const MonthlyAnalaysis({this.dailyShopFilteredForYear});

  final List dailyShopFilteredForYear;

  @override
  State<MonthlyAnalaysis> createState() => _MonthlyAnalaysisState();
}

class _MonthlyAnalaysisState extends State<MonthlyAnalaysis> {
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    //final items = Provider.of<DailyShopData>(context).dailyShopList;

    final monthSelected =
        Provider.of<ShopModelDataForStore>(context).monthOfAYear;

    final dailyShopFilteredForMonth = widget.dailyShopFilteredForYear
        .where((element) => DateTime.parse(element.date).month == selectedMonth)
        .toList();
    final newLabour = dailyShopFilteredForMonth
        .map((e) => ShopModel(
              price: e.price,
              name: e.name,
              quantity: e.quantity,
              date: DateFormat.yMMMEd().format(
                DateTime.parse(e.date),
              ),
            ))
        .toList();
    Provider.of<ShopHandler>(context, listen: false).fileList = newLabour;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(3, 83, 151, 1),
          ),
        ),
        title: const Text('Daily Shop'),
        actions: [
          DropdownButton(
            dropdownColor: Colors.grey[850],
            iconEnabledColor: Colors.white,
            menuMaxHeight: 300,
            value: selectedMonth,
            items: monthSelected
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
                selectedMonth = value;
              });
            },
          ),
        ],
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(_w / 30),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: dailyShopFilteredForMonth.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                horizontalOffset: -300,
                verticalOffset: -850,
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      const SizedBox(
                        width: 65,
                      ),
                      IconButton(
                        color: Colors.red,
                        onPressed: () => showDialog(
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
                                  Provider.of<DailyShopData>(context,
                                          listen: false)
                                      .deleteDailyShopList(
                                          dailyShopFilteredForMonth[index].id);

                                  Navigator.of(ctx).pop(true);
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                            content: const Text(
                                'Do you want to remove the Labour from the List?'),
                          ),
                        ),
                        icon: const Icon(
                          Icons.delete_forever,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      const SizedBox(
                        width: 65,
                      ),
                      IconButton(
                        color: Colors.green,
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (_) => ShopUpdateForm(
                            existedTotal:
                                dailyShopFilteredForMonth[index].total,
                            existedDate: dailyShopFilteredForMonth[index].date,
                            existedName: dailyShopFilteredForMonth[index].name,
                            existedPrice:
                                dailyShopFilteredForMonth[index].price,
                            existedQuantity:
                                dailyShopFilteredForMonth[index].quantity,
                            index: dailyShopFilteredForMonth[index].id,
                          ),
                        ),
                        icon: const Icon(
                          Icons.edit,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  dailyShopFilteredForMonth[index].price,
                                  style: storageItemMoney,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'ETB',
                                  style: storageItemCurrency,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  dailyShopFilteredForMonth[index].name,
                                  style: storageItemName,
                                ),
                              ),
                              trailing: Text(
                                'x ${dailyShopFilteredForMonth[index].quantity}',
                                style: storageItemName,
                              ),
                              subtitle: Text(
                                DateFormat.yMMMEd().format(
                                  DateTime.parse(
                                      dailyShopFilteredForMonth[index].date),
                                ),
                                style: storageItemDate,
                              ),
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: _w / 20),
                    height: _w / 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Provider.of<ShopHandler>(context, listen: false).createTable();
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
